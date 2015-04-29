var express = require('express'),
	i18n = require('i18n'),
	request = require('request'),
	commit = null,
	moment = require('moment'),
	fs = require('fs');

var app = express();

i18n.configure({
	locales:['en'],
	defaultLocale: 'en',
	directory: __dirname + '/locales',
	updateFiles: false
});

app.use(i18n.init);

app.use(express.static(__dirname + '/assets'));
app.set('view engine', 'ejs');

updateCache = function(callback){
	request('https://api.github.com/repos/SMSSecure/SMSSecure/commits', {timeout: parseInt(process.env.TIMEOUT) || 2000, headers: {'User-Agent': 'SMSSecure Website'}}, function (err, res) {
		if (err || typeof res == 'undefined' || typeof res.statusCode == 'undefined' || res.statusCode != 200) return callback(true);
		fs.writeFile('./cache.json', res.body, function (err) {
			if (err) return callback("Cannot write cache.json");
			return callback(null, JSON.parse(res.body));
		});
	});
};

getCache = function(callback){
	fs.readFile('./cache.json', function (err, data) {
		if (err) return callback(err);
		return callback(null, JSON.parse(data));
	});
};

getCacheTime = function(callback){
	fs.stat('./cache.json', function(err, stats){
		if (err) return callback(err);
		return callback(null, Math.floor((new Date().getTime()-stats.mtime.getTime())/1000/60));
	});
};

getCommits = function(callback){
	getCacheTime(function(err, time){
		var cache = parseInt(process.env.CACHE) || 5;
		if (err || time >= cache){
			updateCache(function(err, json){
				console.log('Updating cache...');
				return callback(err, json);
			});
		} else {
			getCache(function(err, json){
				console.log('Using cache...');
				return callback(err, json);
			});
		}
	});
};

app.get('/', function (req, res) {

	moment.locale(res.locale);

	getCommits(function(err, json){
		if (err) console.log(err);
		if (!err){
			commit = {};
			commit.message = json[0].commit.message.split('\n')[0];
			commit.date = moment(json[0].commit.author.date).fromNow();
			commit.author = json[0].author.login;
			commit.link = 'https://github.com/SMSSecure/SMSSecure/commit/'+json[0].sha;
		}
		return res.render('index', {req: req, res: res, commit: commit});
	});
})

var server = app.listen(parseInt(process.env.PORT) || 3000, function () {
	console.log('App listening at http://%s:%s', server.address().address, server.address().port);
})
