# simple-web-app
A simple example node app that listens on port 80 and serves a demo file
## CI/CD
* Listen to a github hook when a commit to master is made.
* Run "npm run test"
* If passed, run "npm run build"
* If passed, copy /dist to CDN, build and publish new docker container, deploy to k8s cluster
