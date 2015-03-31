var express = require('express'),
	i18n = require('i18n'),
	request = require('request'),
	feed = require('fast-feed'),
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
			request(process.env.GIT_RSS || 'https://github.com/SMSSecure/SMSSecure/commits.atom', {timeout: parseInt(process.env.TIMEOUT) || 2000}, function (err, res) {
				return callback(err, res);
			});
		},
		function(res, callback){
			if (res.statusCode != 200) return callback(true);
			feed.parse(res.body, function(err, feed) {
				return callback(err, feed);
			});
		}
	], function(err, feed){
		if (err) console.log(err);
		if (!err){
			commit = feed.items[0];
			commit.title = commit.title.replace(/\n */g, '');
			commit.date = moment(commit.date).fromNow();
		}
		return res.render('index', {req: req, res: res, commit: commit});
	});

})

var server = app.listen(parseInt(process.env.PORT) || 3000, function () {
	console.log('App listening at http://%s:%s', server.address().address, server.address().port);
})
