# Node v8 Service Example

The Node v8 service example demonstrates how to put together a node service for
local development and container-based production hosting.

It uses two Outrigger containers:
* [outrigger/node](https://hub.docker.com/r/outrigger/node) ([github](https://github.com/phase2/docker-node))
* [outrigger/https-proxy](https://hub.docker.com/r/outrigger/https-proxy) ([github](https://github.com/phase2/docker-https-proxy))

## Features

### Yarn Dependency Management

Using Yarn for dependency management, and the Yarn offline mirror to accelerate
builds and allow for offline builds.

### ESlint Code Quality checks

Set up to enforce AirBnb Coding standards.

### Process Supervisor/Watcher

Using nodemon to auto-restart the service on file changes.
(Only for development purposes.)

### Local "demo" mode

Run your app in non-development mode with this one-liner:

```
docker-compose -f docker-compose.yml up -d
```

This is useful not only for demos but also to operate a "backing service" for
another app in progress where you do not need the overhead of a full development
environment.

### Production-ready Containers

Code built-in to lean, Alpine-based containers, running node without the root user.

All set to build, tag, and push to your container registry of choice.

### SSL Termination

Out-of-box support for TLS termination via dedicated proxy container.

## So You Want To Use NPM?

npm is a perfectly fine choice for dependency management. We are using Yarn in
this example for two reasons:

1. The offline mirror functionality means we can speed builds faster than
   regular caching, even in npm v5.
2. The built-in support for Yarn Workspaces makes it easy to apply a mono-repo
   pattern.

If you want to switch to npm v5 instead, take the following steps:

* Edit package.json engines to swap in `"npm": "5.x"` where it currently lists yarn.
* Remove the lines in the Dockerfile that speak of Yarn, and uncomment the npm lines.
* Replace yarn for npm in docker-compose.override.yml
* Delete `.yarnrc`
