#!/bin/bash


# set working directory to script directory
cd "${0%/*}"



# Java uses additional memory on top of this value
RAM=32G


# Using aikar's flags
# https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/

java -Xms${RAM} -Xmx${RAM} -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
	-XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions \
	-XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
	-XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
	-XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 \
	-XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 \
	-XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 \
	-XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
	-Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true \
	-jar paper.jar nogui
