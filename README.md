# docker-lovejs

I wanted to be able to build lovejs in docker, with sockets-websocket-proxy extensions.

## Instructions

You will need docker installed.

```
git clone --depth=1 --recursive https://github.com/konsumer/docker-lovejs.git
cd docker-lovejs
docker-compose up
```

This will create out/ that has all your files in it.

You can use `docker-compose up --build` to force a rebuild. You can also explore the container without building by running `docker-compose run lovejs_builder bash`
