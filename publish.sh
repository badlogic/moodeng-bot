#!/bin/bash
set -e
npm run build
host=slayer.marioslab.io
host_dir=/home/badlogic/moodengbot.mariozechner.at

rsync -avz --exclude node_modules --exclude .git --exclude data --exclude docker/data ./ $host:$host_dir

if [ "$1" == "server" ]; then
    echo "Publishing client & server"
    ssh -t $host "export MOODENGBOT_ACCOUNT=$MOODENGBOT_ACCOUNT && export MOODENGBOT_PASSWORD="$MOODENGBOT_PASSWORD" && cd $host_dir && ./docker/control.sh stop && ./docker/control.sh start && ./docker/control.sh logs"
else
    echo "Publishing client only"
fi