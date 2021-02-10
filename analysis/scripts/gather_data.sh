#Download all the samples for the benchmark
mkdir samples

#pbmc1k_v3
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/pbmc_1k_v3
wget  https://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_1k_v3/pbmc_1k_v3_fastqs.tar
#mv the fq.gz files to a directory called: "samples/human-pbmc1k_v3"
mkdir samples/human-pbmc1k_v3
tar -xvf pbmc_1k_v3_fastqs.tar
mv pbmc_1k_v3_fastqs/*.fq.gz samples/human-pbmc_1k_v3

#pbmc10k_v3
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/pbmc_10k_v3
wget  https://cg.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_10k_v3/pbmc_10k_v3_fastqs.tar
#mv the fq.gz files to a directory called: "samples/human-pbmc_10k_v3"
mkdir samples/human-pbmc10k_v3
tar -xvf pbmc_1k_v3_fastqs.tar
mv pbmc_10k_v3_fastqs/*.fq.gz samples/human-pbmc10k_v3

#heart1k_V2
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/heart_1k_v2
wget  https://cf.10xgenomics.com/samples/cell-exp/3.0.0/heart_1k_v2/heart_1k_v2_fastqs.tar
#mv the fq.gz files to a directory called: "samples/mouse-heart1k_v2"
mkdir samples/mouse-heart1k_v2
tar -xvf heart_1k_v2_fastqs.tar
mv heart_1k_v2_fastqs/*.fastq.gz samples/mouse-heart1k_v2

#heart1k_v3
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/heart_1k_v3
wget  https://cf.10xgenomics.com/samples/cell-exp/3.0.0/heart_1k_v3/heart_1k_v3_fastqs.tar
#mv the fq.gz files to a directory called: "samples/mouse-heart1k_v3"
mkdir samples/mouse-heart1k_v3
tar -xvf heart_1k_v3_fastqs.tar
mv heart_1k_v3_fastqs/*.fq.gz samples/mouse-heart1k_v3

#neuron10k_v3
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/neuron_10k_v3
wget  https://cg.10xgenomics.com/samples/cell-exp/3.0.0/neuron_10k_v3/neuron_10k_v3_fastqs.tar
#mv the fq.gz files to a directory called: "samples/mouse-neuron10k_v3"
mkdir samples/mouse-neuron10k_v3
tar -xvf neuron_10k_v3_fastqs.tar
mv neuron_10k_v3_fastqs/*.fq.gz samples/mouse-neuron10k_v3

#hgmm1k_v2
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/hgmm_1k_v2
wget  https://cf.10xgenomics.com/samples/cell-exp/3.0.0/hgmm_1k_v2/hgmm_1k_v2_fastqs.tar
#mv the fq.gz files to a directory called: "samples/human_mouse-hgmm1k_v2"
mkdir samples/human_mouse-hgmm1k_v2
tar -xvf hgmm_1k_v2_fastqs.tar
mv hgmm_1k_v2_fastqs/*.fq.gz samples/human_mouse-hgmm1k_v2

#hgmm1k_v3
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/hgmm_1k_v3
wget  https://cf.10xgenomics.com/samples/cell-exp/3.0.0/hgmm_1k_v3/hgmm_1k_v3_fastqs.tar
#mv the fq.gz files to a directory called: "samples/human_mouse-hgmm_1k_v3"
mkdir samples/human_mouse-hgmm1k_v3
tar -xvf hgmm_1k_v3_fastqs.tar
mv hgmm_1k_v3_fastqs/*.fq.gz samples/human_mouse-hgmm1k_v3

#hgmm10k_v3
#https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/hgmm_10k_v3
wget  https://cg.10xgenomics.com/samples/cell-exp/3.0.0/hgmm_10k_v3/hgmm_10k_v3_fastqs.tar
#mv the fq.gz files to a directory called: "samples/human_mouse-hgmm_10k_v3"
mkdir samples/human_mouse-hgmm10k_v3
tar -xvf hgmm_10k_v3_fastqs.tar
mv hgmm_10k_v3_fastqs.tar/*.fq.gz samples/human_mouse-hgmm10k_v3

#SRR6998058
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR6998058
wget  https://sra-pub-src-1.s3.amazonaws.com/SRR6998058/Inf_rep1_possorted_genome_bam.bam.1
bamtofastq Inf_rep1_possorted_genome_bam.bam.1 reads
#mv the fq.gz files to a directory called: "samples/mouse-SRR6998058_v2"
mkdir samples/mouse-SRR6998058_v2
cd reads/Inf_Rep1_aggregate_counts_MissingLibrary_1_HYY5NBCXY/
rename bamtofastq bamtofastq1 *
cd ../Inf_Rep1_aggregate_counts_MissingLibrary_1_H2VNNBCX2/
rename bamtofastq bamtofastq2 *
cd ../../
mv reads/*/*.fastq.gz samples/mouse-SRR6998058_v2

#SRR7299563
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR7299563
wget  https://sra-pub-src-1.s3.amazonaws.com/SRR7299563/Vehicle_ExtendedRef.bam.1
bamtofastq Vehicle_ExtendedRef.bam.1 reads
#mv the fq.gz files to a directory called: "samples/rat-SRR7299563_v2"
mkdir samples/rat-SRR7299563_v2
mv reads/*/*.fastq.gz samples/rat-SRR7299563_v2

#SRR6956073
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR6956073
wget  https://sra-pub-src-1.s3.amazonaws.com/SRR6956073/10xWT6S_possorted_genome_bam.bam.1
bamtofastq 10xWT6S_possorted_genome_bam.bam.1 reads
#mv the fq.gz files to a directory called: "samples/zebrafish-SRR6956073_v2"
mkdir samples/zebrafish-SRR6956073_v2
cd reads/ZF6S_WT_10X1_MissingLibrary_1_HMMNFBGX3/
rename bamtofastq bamtofastq1 *
cd ../ZF6S_WT_10X1_MissingLibrary_1_HN5JGBGX3/
rename bamtofastq bamtofastq2 *
cd ../../
mv reads/*/*.fastq.gz samples/zebrafish-SRR6956073_v2

#SRR8206317
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR8206317
wget  https://sra-pub-src-1.s3.amazonaws.com/SRR8206317/d10_Tet_possorted_genome_bam.bam.1
bamtofastq d10_Tet_possorted_genome_bam.bam.1 reads
#mv the fq.gz files to a directory called: "samples/mouse-SRR8206317_v2"
mkdir samples/mouse-SRR8206317_v2
mv reads/*/*.fastq.gz samples/mouse-SRR8206317_v2

#SRR8327928
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR8327928
wget  https://sra-pub-src-1.s3.amazonaws.com/SRR8327928/PDX110_possorted_genome_bam.bam.1
bamtofastq PDX110_possorted_genome_bam.bam.1 reads
#mv the fq.gz files to a directory called: "samples/human-SRR8327928_v2"
mkdir samples/human-SRR8327928_v2
mv reads/*/*.fastq.gz samples/human-SRR8327928_v2

#SRR8524760
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR8524760
wget  https://sra-pub-src-1.s3.amazonaws.com/SRR8524760/KS_10x_iPSC_KS1_K1_1.bam.1
bamtofastq KS_10x_iPSC_KS1_K1_1.bam.1 reads
#mv the fq.gz files to a directory called: "samples/human-SRR8524760_v2"
mkdir samples/human-SRR8524760_v2
mv reads/*/*.fastq.gz samples/human-SRR8524760_v2

#SRR8611943
wget  https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos3/sra-pub-run-21/SRR8611943/SRR8611943.1
fastq-dump --split-files ./SRR8611943.1
#mv the fq.gz files to a directory called: "samples/worm-SRR8611943_v2"
mkdir samples/worm-SRR8611943_v2
gzip *.fastq
mv *.fastq.gz samples/worm-SRR8611943_v2

#SRR8639063
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR8639063
wget  https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos3/sra-pub-run-20/SRR8639063/SRR8639063.1
fastq-dump --split-files ./SRR8639063.1
#mv the fq.gz files to a directory called: "samples/mouse-SRR8639063_v2"
mkdir samples/mouse-SRR8639063_v2
gzip *.fastq
mv *.fastq.gz samples/mouse-SRR8639063_v2

#SRR8257100
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR8257100
wget  https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR8257100/SRR8257100.1
fastq-dump --split-files ./SRR8257100.1
#mv the fq.gz files to a directory called: "samples/arabidopsis-SRR8257100_v2"
mkdir samples/arabidopsis-SRR8257100_v2
gzip *.fastq
mv *.fastq.gz samples/arabidopsis-SRR8257100_v2

#SRR8513910
#https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR8513910
wget  https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos3/sra-pub-run-19/SRR8513910/SRR8513910.1
fastq-dump --split-files ./SRR8513910.1
#mv the fq.gz files to a directory called: "samples/fly-SRR8513910_v2"
mkdir samples/fly-SRR8513910_v2
gzip *.fastq
mv *.fastq.gz samples/fly-SRR8513910_v2

#SRR8599150_v2
fastq-dump --split-files SRR8599150
#mv the fq.gz files to a directory called: "samples/mouse-SRR8599150_v2"
mkdir samples/mouse-SRR8599150_v2
gzip *.fastq
mv *.fastq.gz samples/mouse-SRR8599150_v2

#EMTAB7320
#https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-7320/samples/
wget  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/experiment/MTAB/E-MTAB-7320/SAG657A3_S2_L002_R1_001.fastq.gz
wget  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/experiment/MTAB/E-MTAB-7320/SAG657A3_S2_L002_R2_001.fastq.gz
#mv the fq.gz files to a directory called: "samples/mouse-EMTAB7320_v2"
mkdir samples/mouse-EMTAB7320_v2
mv *.fastq.gz samples/mouse-EMTAB7320_v2