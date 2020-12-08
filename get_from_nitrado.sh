#!/bin/bash

wget --user=ni4469609_1 -m --ask-password ftp://ms1632.gamedata.io/minecraftbukkit/

rsync -a -v ms1632.gamedata.io/minecraftbukkit/ ./
sed -i -E 's/port=([0-9]+)/port=25565/g' server.properties
sed -i -E 's/server-ip=([0-9.]+)/server-ip=/g' server.properties
