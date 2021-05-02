#!/bin/bash


# set working directory to script directory
cd "${0%/*}"



# Java uses additional memory on top of this value
gigs=24



newsizepercent=30
maxnewsizepercent=40
heapregionsize=8M
reservepercent=20
initiatingheapoccupancypercent=15

# Adjust parameters for large amounts of memory
if [ "${gigs}" -gt 12 ]; then
	newsizepercent=40
	maxnewsizepercent=50
	heapregionsize=16M
	reservepercent=15
	initiatingheapoccupancypercent=20
fi

# Using aikar's flags
# https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/

java -Xms${gigs}G -Xmx${gigs}G -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
	-XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions \
	-XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
	-XX:G1NewSizePercent=${newsizepercent} -XX:G1MaxNewSizePercent=${maxnewsizepercent} \
	-XX:G1HeapRegionSize=${heapregionsize} -XX:G1ReservePercent=${reservepercent} \
	-XX:InitiatingHeapOccupancyPercent=${initiatingheapoccupancypercent} \
	-XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
	-XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 \
	-XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
	-Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true \
	-jar paper.jar nogui
