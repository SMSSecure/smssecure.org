#!/bin/bash
set -eo pipefail

if [[ ! -L "$PWD/assets/js/jquery.js" ]]; then
	ln -s "$PWD/node_modules/jquery/dist/jquery.min.js" "$PWD/assets/js/jquery.js"
fi

if [[ ! -L "$PWD/assets/js/jquery-scrollto.js" ]]; then
	ln -s "$PWD/node_modules/jquery.scrollto/jquery.scrollTo.min.js" "$PWD/assets/js/jquery-scrollto.js"
fi

if [[ ! -L "$PWD/assets/js/jquery-actual.js" ]]; then
	ln -s "$PWD/node_modules/actual/jquery.actual.min.js" "$PWD/assets/js/jquery-actual.js"
fi

if [[ ! -L "$PWD/assets/js/bootstrap.js" ]]; then
	ln -s "$PWD/node_modules/bootstrap/dist/js/bootstrap.min.js" "$PWD/assets/js/bootstrap.js"
fi
if [[ ! -L "$PWD/assets/css/bootstrap.css" ]]; then
	ln -s "$PWD/node_modules/bootstrap/dist/css/bootstrap.min.css" "$PWD/assets/css/bootstrap.css"
fi

if [[ ! -L "$PWD/assets/css/font-awesome.css" ]]; then
	ln -s "$PWD/node_modules/font-awesome/css/font-awesome.min.css" "$PWD/assets/css/font-awesome.css"
fi

if [[ ! -L "$PWD/assets/fonts/FontAwesome.otf" ]]; then
	ln -s "$PWD/node_modules/font-awesome/fonts/FontAwesome.otf" "$PWD/assets/fonts/FontAwesome.otf"
fi
if [[ ! -L "$PWD/assets/fonts/fontawesome-webfont.eot" ]]; then
	ln -s "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.eot" "$PWD/assets/fonts/fontawesome-webfont.eot"
fi
if [[ ! -L "$PWD/assets/fonts/fontawesome-webfont.svg" ]]; then
	ln -s "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.svg" "$PWD/assets/fonts/fontawesome-webfont.svg"
fi
if [[ ! -L "$PWD/assets/fonts/fontawesome-webfont.ttf" ]]; then
	ln -s "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.ttf" "$PWD/assets/fonts/fontawesome-webfont.ttf"
fi
if [[ ! -L "$PWD/assets/fonts/fontawesome-webfont.woff" ]]; then
	ln -s "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.woff" "$PWD/assets/fonts/fontawesome-webfont.woff"
fi

if [[ "$NODE_ENV" == "production" ]]; then
	forever --spinSleepTime=10000 --minUptime=10000 start app.js
else
	node ./app.js
fi
