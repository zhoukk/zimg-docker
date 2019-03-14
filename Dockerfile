FROM centos AS build
RUN yum install -y git make cmake gcc gcc-c++ autoconf automake libtool nasm \
        openssl-devel libevent-devel libjpeg-devel giflib-devel libpng-devel libwebp-devel ImageMagick-devel libmemcached-devel && \
        git clone https://github.com/buaazp/zimg -b master --depth=1 && \
        cd zimg && make

FROM alpine
WORKDIR /app
COPY --from=build /zimg/bin/zimg /app
COPY zimg.lua /app

EXPOSE 4869
CMD ./zimg zimg.lua
