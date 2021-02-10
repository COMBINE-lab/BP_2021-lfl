#!/bin/bash

CONFIG='config.json'
if [[ $# -ge 1 ]]; then
	CONFIG=$1
fi

OUTDIR=$(jq -r '.out_dir' ${CONFIG})
REFDIR=$(jq -r '.ref_dir' ${CONFIG})
READSDIR=$(jq -r '.reads_dir' ${CONFIG})
CONFDIR=$(jq -r '.config_dir' ${CONFIG})
SCRIPTDIR=$(jq -r '.script_dir' ${CONFIG})

SALMON=$(jq -r '.salmon' ${CONFIG})
ALEVINFRY=$(jq -r '.alevinfry' ${CONFIG})

### Running mode - each tool relies on itself for filtering the barcodes

mkdir $OUTDIR/alevin_out/$species-$sample

## Run Alevin fry
for config in $CONFDIR/*; do

        sample=$(jq -r '.sample' ${config})
        tech=$(jq -r '.technology' ${config})
        species=$(jq -r '.species' ${config})

	sal_index='$REFDIR/$species/salmon'
        t2g='$REFDIR/$species/t2g.txt'
	fastqs='$READSDIR/$species-$sample/'

        TECH="chromiumV3"
	if [[ $tech = *2 ]];
	then
		TECH="chromium"
	fi

	mkdir $OUTDIR/alevin_out/$species-$sample

	cmd="bash $SCRIPTDIR/salmon_alevin-fry.sh -o $OUTDIR/alevin_out/$species-$sample/ -i $sal_index -g $t2g -x $TECH -f $fastqs -s $SALMON -a $ALEVINFRY"
	echo $cmd
	eval $cmd 
done
