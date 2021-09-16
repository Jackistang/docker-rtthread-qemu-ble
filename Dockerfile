FROM jackistang/rtthread:4.0.3

ENV HOMEPATH  /usr/home
WORKDIR $HOMEPATH

RUN apt update && apt upgrade -y

# 非交互式构建镜像
ARG DEBIAN_FRONTEND=noninteractive

RUN apt install -y tmux udev systemd git cmake automake libtool libelf-dev elfutils libdw-dev libjson-c-dev libical-dev libreadline-dev libglib2.0-dev libdbus-1-dev libudev-dev libncurses5-dev python3 python3-pip qemu pkg-config

RUN git clone -b 5.55 https://github.com.cnpmjs.org/bluez/bluez.git
RUN git clone -b 0.35 git://git.kernel.org/pub/scm/libs/ell/ell.git

RUN git clone -b json-c-0.15-20200726 https://github.com.cnpmjs.org/json-c/json-c.git \
    && mkdir json-c-build && cd json-c-build   \
    && cmake ../json-c \
    && make    \
    && make install

RUN cd bluez    \
    && ./bootstrap-configure --disable-android --disable-midi --disable-mesh \
    && make
ENV PATH=$HOMEPATH/bluez/tools:$PATH

COPY qemu.sh rt-thread/bsp/qemu-vexpress-a9/qemu.sh
RUN chmod +x rt-thread/bsp/qemu-vexpress-a9/qemu.sh

COPY qemu-dbg.sh rt-thread/bsp/qemu-vexpress-a9/qemu-dbg.sh
RUN chmod +x rt-thread/bsp/qemu-vexpress-a9/qemu-dbg.sh

COPY main.c rt-thread/bsp/qemu-vexpress-a9/applications/main.c

CMD [ "/bin/bash" ]