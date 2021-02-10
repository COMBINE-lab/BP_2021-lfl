#!/bin/bash

usage () {
    echo "Usage: $0 [options]
    
    Options:
    -o, --output            output folder
    -i, --index             pseudoalignment index
    -g, --genemap           transcripts to genes map
    -x, --technology        single-cell tech
    -f, --fastqdir          folder containing fastqs
    -k, --kallisto	    kallisto binary
    -b, --bustools	    bustools binary
    "
    exit 1
}

while getopts ":o:i:g:x:f:k:b:" opt; do
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
if [ -z "$OUTDIR" -o -z "$INDEX" -o -z "$T2G" -o -z "$TECH" -o -z "$FASTQDIR" -o -z "$kallisto" -o -z "$bustools" ]
then
    echo "Error"
    usage
fi

# begin workflow
mkdir -p $OUTDIR

echo ""
echo '[kallisto] pseudoaligning reads..'

/usr/bin/time --output $OUTDIR/pseudoalignment.log -v \
$kallisto bus \
-i $INDEX \
-o $OUTDIR \
-x $TECH \
-t 10 \
$(paste -d" " \
  <(ls $FASTQDIR | awk -v p=$FASTQDIR '{print p$0}' | grep R1) \
  <(ls $FASTQDIR | awk -v p=$FASTQDIR '{print p$0}' | grep R2)) |& stdbuf -oL tr '\r' '\n' > $OUTDIR/pseudoalignment.run.log


echo ""
echo '[bustools] sorting bus file for whitelist generation..'

/usr/bin/time --output $OUTDIR/sort_output.log -v \
$bustools sort \
-t 10 \
-m 4G \
-o $OUTDIR/sorted.bus \
   $OUTDIR/output.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/sort_output.run.log

echo ""
echo '[bustools] generating whitelist..'

/usr/bin/time --output $OUTDIR/whitelist.log -v \
$bustools whitelist \
-o $OUTDIR/whitelist.txt \
   $OUTDIR/sorted.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/whitelist.run.log

echo ""
echo '[bustools] correcting barcodes..'

/usr/bin/time --output $OUTDIR/correct.log -v \
$bustools correct \
-w $OUTDIR/whitelist.txt \
-o $OUTDIR/c.bus \
   $OUTDIR/sorted.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/correct.run.log

echo ""
echo '[bustools] sorting bus file..'

/usr/bin/time --output $OUTDIR/sort_barcodes.log -v \
$bustools sort \
-t 10 \
-m 4G \
-o $OUTDIR/sc.bus \
 $OUTDIR/c.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/sort_barcodes.run.log
   
echo ""
echo '[bustools] counting umis..'

mkdir -p $OUTDIR/count

/usr/bin/time --output $OUTDIR/count.log -v \
$bustools count \
--genecounts \
-g $T2G \
-o $OUTDIR/count/ \
-e $OUTDIR/matrix.ec \
-t $OUTDIR/transcripts.txt \
   $OUTDIR/sc.bus |& stdbuf -oL tr '\r' '\n' > $OUTDIR/count.run.log


#echo ""
#echo "[bustools] converting to text.."

#/usr/bin/time --output $OUTDIR/text.log -v \
#$bustools text \
#-p $OUTDIR/output.bus \
#> /dev/null

echo "Done."
