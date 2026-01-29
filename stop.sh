#!/bin/bash

docker exec -it -u hadoop hadoop1_master bash -cl "stop-yarn.sh && stop-dfs.sh"
