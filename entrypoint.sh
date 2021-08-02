#!/bin/bash

if test -f "//version.txt"; then
  current=$(cat //version.txt)
else
  current='0'
fi

latest=$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json' | //jq -r '.latest.release')
if [ $current == $latest ]
then
  echo 'Up-to-date'
else
  echo 'Version:'$latest' has been released.'
  latest_json=$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json' | //jq -r --arg latest "$latest" '.versions[] | select(.id==$latest) | .url')
  latest_url=$(curl -s $latest_json | //jq -r '.downloads.server.url')
  curl -s -o //server.jar $latest_url
  echo $latest > //version.txt
fi
exec $@
