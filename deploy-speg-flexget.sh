echo ":: building container"
docker build -t speg-flexget .

echo ":: remove old container"
docker container rm flexget-old
echo ":: stop running container"
docker container stop flexget
echo ":: rename stopped container"
docker container rename flexget flexget-old
echo ":: start container"

docker run \
    --name flexget \
    \
    -e FG_LOG_LEVEL=info \
    \
    -p 5050:5050 \
    -p 5051:5051 \
    \
    -e PUID=1000 \
    -e PGID=1001 \
    -e TZ=Europe/Budapest \
    \
    -v /home/pi/docker-data/flexget:/config \
    \
    --cpu-shares 256 \
    \
    --restart unless-stopped \
    -d \
    speg-flexget

#    -e FG_WEBUI_PASSWD=Aranka74F \

echo ":: follow logs"
docker logs -f flexget
