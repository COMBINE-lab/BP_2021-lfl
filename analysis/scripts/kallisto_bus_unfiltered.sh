#!/bin/bash

usage () {
    echo "Usage: $0 [options]
    
    Options:
    -o, --output            output folder
    -i, --index             pseudoalignment index
    -w, --whitelist         10x barcode whitelist
    -g, --genemap           transcripts to genes map
    -x, --technology        single-cell tech
    -f, --fastqdir          folder containing fastqs
    -k, --kallisto	    kallisto binary
    -b, --bustools	    bustools binary
    "
    exit 1
}

while getopts ":o:i:w:g:x:f:k:b:" opt; do
    case $opt in
        o|--output)
            OUTDIR=$OPTARG
            ;;
        i|--index)
            INDEX=$OPTARG
            ;;
        w|--whitelist)
            WHITELIST=$OPTARG
            ;;
        g|--genemap)
            T2G=$OPTARG
            ;;
        x|--technology)
            TECH=$OPTARG
            ;;
        f|--fastqdir)
            FASTQDIR=$OPTARG
            ;;
        k|--kallisto)
            kallisto=$OPTARG
            ;;
        b|--bustools)
            bustools=$OPTARG
	    ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid argument"
            usage
            ;;
        :)
            echo "Add arguments"
            usage
            ;;
    esac
done

# check options        
if [ -z "$OUTDIR" -o -z "$INDEX" -o -z "$WHITELIST" -o -z "$T2G" -o -z "$TECH" -o -z "$FASTQDIR" ]
then
    echo "Error"
    usage
fi

# begin workflow
mkdir -p $OUTDIR

echo ""
echo '[bustools] correcting barcodes..'

/usr/bin/time --output $OUTDIR/correct_unfiltered.log -v \
$bustools correct \
-w $WHITELIST \
-o $OUTDIR/c_unfiltered.bus \
   $OUTDIR/output.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/correct_unfiltered.run.log

echo ""
echo '[bustools] sorting bus file..'

/usr/bin/time --output $OUTDIR/sort_barcodes_unfiltered.log -v \
$bustools sort \
-t 10 \
-m 4G \
-o $OUTDIR/sc_unfiltered.bus \
 $OUTDIR/c_unfiltered.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/sort_barcodes_unfiltered.run.log

echo ""
echo '[bustools] generating the whiteliste..'

/usr/bin/time --output $OUTDIR/whitelist_unfiltered.log -v \
$bustools whitelist \
-o $OUTDIR/whitelist_unfiltered.txt \
   $OUTDIR/sc_unfiltered.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/whitelist_unfiltered.run.log
   
echo ""
echo '[bustools] counting umis..'

mkdir -p $OUTDIR/count

/usr/bin/time --output $OUTDIR/count_unfiltered.log -v \
$bustools count \
--genecounts \
-g $T2G \
-o $OUTDIR/count_unfiltered/ \
-e $OUTDIR/matrix.ec \
-t $OUTDIR/transcripts.txt \
   $OUTDIR/sc_unfiltered.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/count_unfiltered.run.log

echo "Done."
