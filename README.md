# docker-minecraft-direwolf20-1.16

This docker image provides a Minecraft Server, based on the direwolf20 1.16 Feed
The Beast modpack.

To simply use the latest stable version, run:

    docker run -d -p 25565:25565 --name minecraft-dw20-116 joshuacherry/minecraft-direwolf20-1.16

where the default server port, 25565, will be exposed on your host machine. If
you want to serve up multiple Minecraft servers or just use an alternate port,
change the host-side port mapping such as:

    docker run -p 25566:25565 ...

will service port 25566.

You can easily view the logs, stop, or re-start the container with the following commands:

    docker logs -f minecraft
        ( Ctrl-C to exit logs action )

    docker stop minecraft

    docker start minecraft

## Attaching data directory to host filesystem

You will want to create a volume for mounting the container if you want to persist data.

    mkdir -p /minecraft/dw20-116
    docker volume create --driver local --name dw20-116
    docker run --name minecraft-dw20-116 -d -v dw20-116:/data -p 25565:25565 joshuacherry/docker-minecraft-direwolf20-1.16:latest

## Running this container as a service on Ubuntu

If you intend to have this contain running as a service on an Ubuntu VM with docker, you can create a systemd service to manage the docker container by name.

1. Place this in /etc/systemd/system/minecraft-dw20-116.service

    [Unit]
    Description=Direwolf20 1.16 Minecraft Service
    Requires=docker.service
    After=docker.service

    [Service]
    Restart=always
    ExecStart=/usr/bin/docker start -a minecraft-dw20-116
    ExecStop=/usr/bin/docker stop -t 2 minecraft-dw20-116

    [Install]
    WantedBy=multi-user.target

2. modify permissions on the new file

    chmod +x /etc/systemd/system/minecraft-dw20-116.service

3. Reload the systemctl daemon

    sudo systemctl daemon-reload

4. Start and enable your service

    sudo systemctl start minecraft-dw20-116.service
    sudo systemctl enable minecraft-dw20-116.service
