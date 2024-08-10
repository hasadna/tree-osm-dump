trees.json: tree-species-list
	cat tree-species-list | parallel -j1 --bar bash ./get-tree.sh > trees.json

trees.csv: trees.json
	jq -s <trees.json '["name", "lat", "lon", "check_date", "osm", "streetview"], (.[] | [.name,  .lat,  .lon,  .check_date,  .osm,  .streetview]) | @csv' -r >trees.csv
