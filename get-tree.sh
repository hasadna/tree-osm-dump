#!/bin/bash
set -uo pipefail
TREE_NAME="$1"
CURL_OUT="$(curl -sS 'https://overpass-api.de/api/interpreter' --data '[out:json];node[natural=tree][species="'"$TREE_NAME"'"];out ;')"
EX="$?"
if [[ "$EX" != "0" ]] || ! (echo "$CURL_OUT" | jq . >/dev/null); then
  echo "error"
  echo "$CURL_OUT"  | head -n30 >&2
  exit $EX
fi

echo "$CURL_OUT" | jq '.elements[] | {"name": "'"$1"'", lat, lon, "osm": "https://www.openstreetmap.org/node/\(.id)", "streetview": "https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=\(.lat),\(.lon)"}'
