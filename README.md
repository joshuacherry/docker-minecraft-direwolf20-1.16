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

In order to persist the Minecraft data, use the `-v` argument to map a directory of the host to
``/data``:
    docker run --name minecraft-dw20-116 -d -v /minecraft/dw20-116:/data -p 25565:25565 --name minecraft-dw20-116 joshuacherry/minecraft-direwolf20-1.16

When attached in this way you can stop the server, edit the configuration under
your attached ``/path/on/host`` and start the server again with `docker start
CONTAINERID` to pick up the new configuration.
