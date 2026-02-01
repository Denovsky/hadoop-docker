#!/bin/bash

docker exec -it -u 0 hadoop1_master bash -cl "apt install python3-pip python3-venv"
docker exec -it -u hadoop hadoop1_master bash -cl "python3 -m venv /home/hadoop"
