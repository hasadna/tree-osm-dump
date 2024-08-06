#!/bin/bash
set -uo pipefail
TREE_NAME="$1"
CURL_OUT="$(curl -sS 'https://overpass-api.de/api/interpreter' --data '[out:json];node["highway"~"living_street|pedestrian|residential"](around:10);node[natural=tree][species="'"$TREE_NAME"'"];out ;')"
EX="$?"
echo "$CURL_OUT"
if [[ "$EX" != "0" ]] || ! (echo "$CURL_OUT" | jq . >/dev/null); then
  echo "error"
  echo "$CURL_OUT"  | head -n30 >&2
  exit $EX
fi

echo "$CURL_OUT" | jq '.elements[] | {"name": "'"$1"'", lat, lon, "check_date": .tags.check_date ,"osm": "https://www.openstreetmap.org/node/\(.id)", "streetview": "https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=\(.lat),\(.lon)"}'
