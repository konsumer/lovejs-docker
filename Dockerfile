FROM emscripten/emsdk as lovejs_builder

# output
VOLUME /out

ADD https://raw.githubusercontent.com/Davidobot/love.js/master/src/game.js /src/game.js
ADD https://raw.githubusercontent.com/Davidobot/love.js/master/src/release/index.html /src/index.html

RUN apt-get update && apt-get install -y build-essential autotools-dev automake libtool \
pkg-config libfreetype6-dev libluajit-5.1-dev libphysfs-dev libsdl2-dev \
libopenal-dev libogg-dev libvorbis-dev libmodplug-dev libmpg123-dev \
libtheora-dev autoconf cmake \
 && rm -rf /var/lib/apt/lists/*

# # wasm normal
# CMD mkdir -p /work && \
#   cd /work && \
#   emcmake cmake /src/megasource -DLOVE_JIT=0 -DCMAKE_BUILD_TYPE=Release && \
#   emmake make -j 6 && \
#   cp love/love.js* love/love.wasm love/love.worker.js /out

# # wasm compat
# CMD mkdir -p /work && \
#   cd /work && \
#   emcmake cmake /src/megasource -DLOVE_JIT=0 -DCMAKE_BUILD_TYPE=Release -DLOVEJS_COMPAT=1 && \
#   emmake make -j 6 && \
#   cp love/love.js* love/love.wasm love/love.worker.js /out

# wasm normal with networking
CMD mkdir -p /src/build && cd /src/build && \
  emcmake cmake /src/megasource -DLOVE_JIT=0 -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-lwebsocket.js -s PROXY_POSIX_SOCKETS=1 -s USE_PTHREADS=1 -s PROXY_TO_PTHREAD=1" && \
  emmake make -j 6 && \
  cp /src/game.js /src/index.html love/love.js* love/love.wasm love/love.worker.js /out && chown -R 1000:1000 /out

