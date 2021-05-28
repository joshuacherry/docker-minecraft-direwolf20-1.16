FROM openjdk:8

LABEL Josh Cherry <joshuarcherry@gmail.com>

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/minecraft && cd /tmp/minecraft && \
	wget -c  https://api.modpacks.ch/public/modpack/79/2055/server/linux -O MCinstaller && \
	chmod +x MCinstaller && \
	./MCinstaller 79 1.10.1 --auto && \
	chown -R minecraft /tmp/minecraft

USER minecraft
EXPOSE 25565 25565
ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD ["sh","/start"]
ENV JVM_OPTS -XX:+UseG1GC -Xmx8G -Xms4G -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M