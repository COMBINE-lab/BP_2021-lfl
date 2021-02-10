#!/bin/bash

CONFIG='config.json'
if [[ $# -ge 1 ]]; then
	CONFIG=$1
fi

REFDIR=$(jq -r '.ref_dir' ${CONFIG})

SALMON=$(jq -r '.salmon' ${CONFIG})
KALLISTO=$(jq -r '.kallisto' ${CONFIG})

for species in 'fly' 'worm' 'rat' 'zebrafish' 'arabidopsis' 'human' 'mouse' 'human_mouse'; do

ref="$REFDIR/$species/*.fa"

cmd="/usr/bin/time -o $REFDIR/$species/salmon.log -v $SALMON index -i $REFDIR/$species/salmon -t $ref -p 10 |& stdbuf -oL tr '\r' '\n' > $REFDIR/$species/salmon.build.log "
echo $cmd
eval $cmd

done

for species in 'fly' 'worm' 'rat' 'zebrafish' 'arabidopsis' 'human' 'mouse' 'human_mouse'; do

ref="$REFDIR/$species/*.fa"

cmd="/usr/bin/time -o $REFDIR/$species/kallisto.log -v $KALLISTO index -i $REFDIR/$species/kallisto $ref |& stdbuf -oL tr '\r' '\n' > $REFDIR/$species/kallisto.build.log"
echo $cmd
eval $cmd

done
