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

KALLISTO=$(jq -r '.kallisto' ${CONFIG})
BUSTOOLS=$(jq -r '.bustools' ${CONFIG})

### Running mode - each tool relies on itself for filtering the barcodes

mkdir $OUTDIR/kallisto_out

## Run kallisto bus
for config in $CONFDIR/*; do

        sample=$(jq -r '.sample' ${config})
        tech=$(jq -r '.technology' ${config})
        species=$(jq -r '.species' ${config})

        kal_index='$REFDIR/$species/kallisto'
        t2g='$REFDIR/$species/t2g.txt'
	fastqs='$READSDIR/$species-$sample/'

        TECH="10xv3"
	if [[ $tech = *2 ]];
	then
		TECH="10xv2"
	fi

	mkdir $OUTDIR/kallisto_out/$species-$sample

	cmd="bash $SCRIPTDIR/kallisto_bus.sh -o $OUTDIR/kallisto_out/$species-$sample/ -i $kal_index -g $t2g -x $TECH -f $fastqs -k $KALLISTO -b $BUSTOOLS"
	echo $cmd
	eval $cmd 
done
