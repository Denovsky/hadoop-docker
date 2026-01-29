#!/bin/bash

docker exec -it -u hadoop hadoop1_master bash -cl "start-dfs.sh && start-yarn.sh"