#!/bin/bash

usage () {
    echo "Usage: $0 [options]
    
    Options:
    -o, --output            output folder
    -i, --index             pseudoalignment index directory
    -g, --genemap           transcripts to genes map
    -x, --technology        single-cell tech 'chromium' or 'chromiumV3'
    -f, --fastqdir          folder containing fastqs
    -s, --salmon	    salmon binary
    -a, --alevin-fry	    alevin-fry binary
    "
    exit 1
}

while getopts ":o:i:g:x:f:s:a:" opt; do
    case $opt in
        o|--output)
            OUTDIR=$OPTARG
            ;;
        i|--index)
            INDEX=$OPTARG
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
        s|--salmon)
            salmon=$OPTARG
            ;;
        a|--alevin-fry)
            alevinfry=$OPTARG
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
if [ -z "$OUTDIR" -o -z "$INDEX" -o -z "$T2G" -o -z "$TECH" -o -z "$FASTQDIR" -o -z "$salmon" -o -z "$alevinfry" ]
then
    echo "Error"
    usage
fi

# begin workflow
mkdir -p $OUTDIR

echo ""
echo '[salmon] pseudoaligning reads..'

/usr/bin/time --output $OUTDIR/pseudoalignment.log -v \
$salmon alevin \
-l ISR \
-i $INDEX \
-1 $(ls $FASTQDIR | awk -v p=$FASTQDIR '{print p$0}' | grep R1) \
-2 $(ls $FASTQDIR | awk -v p=$FASTQDIR '{print p$0}' | grep R2) \
--tgMap $T2G \
-o $OUTDIR \
--rad \
--sketch \
-p 10 \
--$TECH |& stdbuf -oL tr '\r' '\n' > $OUTDIR/pseudoalignment.run.log
  

echo ""
echo '[alevin-fry] generating the permitlist..'

PL="$OUTDIR/permitlist"

/usr/bin/time --output $OUTDIR/permitlist.log -v \
$alevinfry generate-permit-list \
-d fw \
-i $OUTDIR \
-o $PL \
--knee-distance |& stdbuf -oL tr '\r' '\n' > $OUTDIR/permitlist.run.log
   
echo ""
echo '[alevin-fry] collating rad file..'


/usr/bin/time --output $OUTDIR/collate.log -v \
$alevinfry collate \
-i $PL \
-r $OUTDIR \
-t 10 |& stdbuf -oL tr '\r' '\n' > $OUTDIR/collate.run.log
   
echo ""
echo '[alevin-fry] counting umis..'


QNT="$OUTDIR/quant"

/usr/bin/time --output $OUTDIR/quant.log -v \
$alevinfry quant \
-r cr-like \
--use-mtx \
-i $PL \
-o $QNT \
-m $T2G \
-t 10 |& stdbuf -oL tr '\r' '\n' > $OUTDIR/quant.run.log

#echo ""
#echo "[alevin-fry] converting to text"

#/usr/bin/time --output $OUTDIR/text.log -v \
#$alevinfry view \
#--rad $OUTDIR/map.rad \
#--header \
#> /dev/null

echo "Done."
