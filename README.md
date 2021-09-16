# docker-rtthread-qemu-ble

首先利用下述命令创建一个 Docker 容器：
```shell
sudo docker run --net=host --privileged -it jackistang/rtthread-qemu-ble:1.0.0 /bin/bash
```

然后在容器里利用 [tmux](https://www.ruanyifeng.com/blog/2019/10/tmux.html) 创建一个窗口运行 `btproxy`：

```shell
root@tangjia:/usr/home# hciconfig
hci0:   Type: Primary  Bus: USB
        BD Address: 58:00:E3:01:11:15  ACL MTU: 1022:8  SCO MTU: 183:5
        UP RUNNING 
        RX bytes:3385 acl:0 sco:0 events:229 errors:0
        TX bytes:12012 acl:0 sco:0 commands:235 errors:0
      
root@tangjia:/usr/home# btproxy -u -i 0
Listening on /tmp/bt-server-bredr
```

再在 RT-Thread 的 qemu 目录里编译运行程序：

```shell
root@tangjia:/usr/home/rt-thread/bsp/qemu-vexpress-a9# scons

root@tangjia:/usr/home/rt-thread/bsp/qemu-vexpress-a9# ./qemu.sh 
pulseaudio: pa_context_connect() failed
pulseaudio: Reason: Connection refused
pulseaudio: Failed to initialize PA contextaudio: Could not init `pa' audio driver

 \ | /
- RT -     Thread Operating System
 / | \     4.0.3 build Sep 16 2021
 2006 - 2020 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[I/sal.skt] Socket Abstraction Layer initialize success.
CMD => 01 08 20 20 14 02 01 06 0D 09 62 6C 65 68 72 5F 73 65 6E 73 6F 72 02 0A 00 00 00 00 00 00 00 00 00 00 00 00 
msh />EVT <= 04 0E 04 01 08 20 00 
CMD => 01 06 20 0F 30 00 60 00 00 01 00 00 00 00 00 00 00 07 00 
EVT <= 04 0E 04 01 06 20 00 
CMD => 01 0A 20 01 01 
EVT <= 04 0E 04 01 0A 20 00 
hello rt-thread
```

蓝牙广播例程成功运行。
