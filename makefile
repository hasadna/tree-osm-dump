tree-species-list: tree-species-list-raw
	cat tree-species-list-raw  | tail -n+2 | cut -f1 | perl -pe 's/\s+$$/\n/' > tree-species-list

trees.json: tree-species-list
	cat tree-species-list | parallel -j1 --bar bash ./get-tree.sh > trees.json

trees.csv: trees.json
	jq -s <trees.json '["name", "lat", "lon", "check_date", "osm", "streetview"], (.[] | [.name,  .lat,  .lon,  .check_date,  .osm,  .streetview]) | @csv' -r >trees.csv
