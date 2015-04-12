var express = require('express'),
	i18n = require('i18n'),
	request = require('request'),
	async = require('async')
	commit = null,
	moment = require('moment');

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

app.get('/', function (req, res) {

	moment.locale(res.locale);

	async.waterfall([
		function(callback){
			request('https://api.github.com/repos/SMSSecure/SMSSecure/commits', {timeout: parseInt(process.env.TIMEOUT) || 2000, headers: {'User-Agent': 'SMSSecure Website'}}, function (err, res) {
				return callback(err, res);
			});
		},
		function(res, callback){
			if (res.statusCode != 200) return callback(true);
			return callback(null, JSON.parse(res.body));
		}
	], function(err, commits){
		if (err) console.log(err);
		if (!err){
			commit = {};
			commit.message = commits[1].commit.message.split('\n')[0];
			commit.date = moment(commits[0].commit.author.date).fromNow();
			commit.author = commits[0].author.login;
			commit.link = 'https://github.com/SMSSecure/SMSSecure/commit/'+commits[0].sha;
		}
		return res.render('index', {req: req, res: res, commit: commit});
	});

})

var server = app.listen(parseInt(process.env.PORT) || 3000, function () {
	console.log('App listening at http://%s:%s', server.address().address, server.address().port);
})
