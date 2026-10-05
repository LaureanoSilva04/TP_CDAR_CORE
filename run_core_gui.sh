#!/bin/bash

./run_core_container.sh
sleep 3
ssh -p $(docker inspect --format='{{ (index (index .NetworkSettings.Ports "22/tcp") 0).HostPort }}' cdar) -X root@localhost core-gui
