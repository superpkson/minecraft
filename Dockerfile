FROM openjdk:latest

COPY ./jq-linux64 /jq
COPY ./entrypoint.sh /entrypoint.sh

VOLUME ["/mnt/mc"]

EXPOSE 25565
WORKDIR /mnt/mc
ENTRYPOINT ["/entrypoint.sh"]
CMD ["java","-Xmx1G","-Xms1G","-jar","/server.jar","nogui"]
