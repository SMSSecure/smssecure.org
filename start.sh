#!/bin/bash
set -eo pipefail

cp "$PWD/node_modules/jquery/dist/jquery.min.js" "$PWD/assets/js/jquery.js"
cp "$PWD/node_modules/jquery.scrollto/jquery.scrollTo.min.js" "$PWD/assets/js/jquery-scrollto.js"
cp "$PWD/node_modules/bootstrap/dist/js/bootstrap.min.js" "$PWD/assets/js/bootstrap.js"
cp "$PWD/node_modules/bootstrap/dist/css/bootstrap.min.css" "$PWD/assets/css/bootstrap.css"
cp "$PWD/node_modules/fork-awesome/css/fork-awesome.min.css" "$PWD/assets/css/fork-awesome.css"
cp "$PWD/node_modules/fork-awesome/fonts/forkawesome-webfont.eot" "$PWD/assets/fonts/forkawesome-webfont.eot"
cp "$PWD/node_modules/fork-awesome/fonts/forkawesome-webfont.svg" "$PWD/assets/fonts/forkawesome-webfont.svg"
cp "$PWD/node_modules/fork-awesome/fonts/forkawesome-webfont.ttf" "$PWD/assets/fonts/forkawesome-webfont.ttf"
cp "$PWD/node_modules/fork-awesome/fonts/forkawesome-webfont.woff" "$PWD/assets/fonts/forkawesome-webfont.woff"

if [[ "$NODE_ENV" == "production" ]]; then
	forever --spinSleepTime=10000 --minUptime=10000 start app.js
else
	node ./app.js
fi
