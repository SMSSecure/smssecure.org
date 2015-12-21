Website of the SMSSecure project.

## Installation

Just clone or fork this repository and start the application with npm:

```
npm install
npm start
```

To customize some parameters, use environment variables:

```
TIMEOUT=2000 PORT=3000 npm start
```

## Requirements

You need Node.js and npm.

## Docker

To run this app into a Docker container, build the image and run it:

```
docker build -t "smssecure.org:latest" .
docker run --restart=always -d --publish 127.0.0.1:8080:80 smssecure.org:latest
```

Then, visit http://localhost:8080/.

## License

Licensed under the GNU Affero General Public License Version 3 (or later); you may not use this work except in compliance with the License.

You may obtain a copy of the License in the LICENSE file, or at:

http://www.gnu.org/licenses/agpl-3.0.txt

Pictures are licensed under the CC BY 2.0:
https://www.flickr.com/photos/bastienlq/19276132753/
https://www.flickr.com/photos/39908901@N06/6909402464/
