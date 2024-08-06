# Tree mapper
Finds 5 examples of each tree on OSM (Open Street Map), and creats a CSV table with:
* Tree type
* Link to OSM node
* Link to Google Maps Street View of the same location (which might fail as Google Street View might not have captured this specific point)


tree type raw list grabbed from:
https://wiki.openstreetmap.org/wiki/Tag:natural%3Dtree/List_of_Species

# Running things
```
make trees.csv
```
