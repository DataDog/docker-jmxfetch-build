# docker-jmxfetch-build
Docker container to build jmxfetch

This repo contains the Dockerfile used to build [JMXFetch](https://github.com/DataDog/jmxfetch) for the Datadog Agent (https://github.com/DataDog/dd-agent).

## builder
A typical build command could be:
```
# assumes you have a directory pkg to mount.
docker run --name jmxfetch_builder -it -v $(pwd)/pkg:/pkg docker-jmxfetch-build:latest
```

That should drop the `jar` artifact in package. Alternatively, you can provide your own repo.

```
# assumes you have a directory pkg to mount.
docker run --name jmxfetch_builder -it -v $(pwd)/pkg:/pkg -v $(pwd)/repo:/jmxfetch docker-jmxfetch-build:latest
```
