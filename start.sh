#!/bin/bash
set -eo pipefail

cp "$PWD/node_modules/jquery/dist/jquery.min.js" "$PWD/assets/js/jquery.js"
cp "$PWD/node_modules/jquery.scrollto/jquery.scrollTo.min.js" "$PWD/assets/js/jquery-scrollto.js"
cp "$PWD/node_modules/bootstrap/dist/js/bootstrap.min.js" "$PWD/assets/js/bootstrap.js"
cp "$PWD/node_modules/bootstrap/dist/css/bootstrap.min.css" "$PWD/assets/css/bootstrap.css"
cp "$PWD/node_modules/font-awesome/css/font-awesome.min.css" "$PWD/assets/css/font-awesome.css"
cp "$PWD/node_modules/font-awesome/fonts/FontAwesome.otf" "$PWD/assets/fonts/FontAwesome.otf"
cp "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.eot" "$PWD/assets/fonts/fontawesome-webfont.eot"
cp "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.svg" "$PWD/assets/fonts/fontawesome-webfont.svg"
cp "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.ttf" "$PWD/assets/fonts/fontawesome-webfont.ttf"
cp "$PWD/node_modules/font-awesome/fonts/fontawesome-webfont.woff" "$PWD/assets/fonts/fontawesome-webfont.woff"

if [[ "$NODE_ENV" == "production" ]]; then
	forever --spinSleepTime=10000 --minUptime=10000 start app.js
else
	node ./app.js
fi
