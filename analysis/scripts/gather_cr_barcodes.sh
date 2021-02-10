# Run in the analysis/scripts directory

##cellranger v2 and v3 barcodes
wget https://raw.githubusercontent.com/10XGenomics/cellranger/master/lib/python/cellranger/barcodes/translation/3M-february-2018.txt.gz
gunzip 3M-february-2018.txt.gz
cut -f1 3M-february-2018.txt > 10xv3barcodes.txt
rm 3M-february-2018.txt

wget https://raw.githubusercontent.com/10XGenomics/cellranger/master/lib/python/cellranger/barcodes/737K-august-2016.txt
mv 737K-august-2016.txt 10xv2barcodes.txt

#cellranger filtered list for pbmc10k_v3 sample
wget https://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_10k_v3/pbmc_10k_v3_filtered_feature_bc_matrix.tar.gz
tar -xvzf pbmc_10k_v3_filtered_feature_bc_matrix.tar.gz
gunzip filtered_feature_bc_matrix/barcodes.tsv.gz
cut -f1 -d$"-" filtered_feature_bc_matrix/barcodes.tsv > human-pbmc10k_v3.txt
mkdir ../../data/
mkdir ../../data/cellranger_barcodes/
mv human-pbmc10k_v3.txt ../../data/cellranger_barcodes/
rm pbmc_10k_v3_filtered_feature_bc_matrix.tar.gz
rm filtered_feature_bc_matrix/ -r
