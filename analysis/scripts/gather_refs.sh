## Run inside the analysis/scripts directory
## Reference sequences for all the species
mkdir references

#ftp://ftp.ensembl.org/pub/release-102/fasta/danio_rerio/
wget ftp://ftp.ensembl.org/pub/release-102/fasta/danio_rerio/cdna/Danio_rerio.GRCz11.cdna.all.fa.gz
#mv the fasta file to a directory called: "references/zebrafish/"
mkdir references/zebrafish/
gunzip Danio_rerio.GRCz11.cdna.all.fa.gz
bash mkt2g_rest.sh Danio_rerio.GRCz11.cdna.all.fa 
mv t2g.txt references/zebrafish/
mv Danio_rerio.GRCz11.cdna.all.fa references/zebrafish/

#ftp://ftp.ensemblgenomes.org/pub/release-49/plants/fasta/arabidopsis_thaliana/
wget ftp://ftp.ensemblgenomes.org/pub/release-49/plants/fasta/arabidopsis_thaliana/cdna/Arabidopsis_thaliana.TAIR10.cdna.all.fa.gz
#mv the fasta file to a directory called: "references/arabidopsis/"
mkdir references/arabidopsis/
gunzip Arabidopsis_thaliana.TAIR10.cdna.all.fa.gz
bash mkt2g_rest.sh Arabidopsis_thaliana.TAIR10.cdna.all.fa
mv t2g.txt references/arabidopsis/
mv Arabidopsis_thaliana.TAIR10.cdna.all.fa references/arabidopsis/

#ftp://ftp.ensembl.org/pub/release-102/fasta/caenorhabditis_elegans/
wget ftp://ftp.ensembl.org/pub/release-102/fasta/caenorhabditis_elegans/cdna/Caenorhabditis_elegans.WBcel235.cdna.all.fa.gz
#mv the fasta file to a directory called: "references/worm/"
mkdir references/worm/
gunzip Caenorhabditis_elegans.WBcel235.cdna.all.fa.gz
bash mkt2g_rest.sh Caenorhabditis_elegans.WBcel235.cdna.all.fa
mv t2g.txt references/worm/
mv Caenorhabditis_elegans.WBcel235.cdna.all.fa references/worm/

#ftp://ftp.ensembl.org/pub/release-102/fasta/drosophila_melanogaster/
wget ftp://ftp.ensembl.org/pub/release-102/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP6.28.cdna.all.fa.gz
#mv the fasta file to a directory called: "references/fly/"
mkdir references/fly/
gunzip Drosophila_melanogaster.BDGP6.28.cdna.all.fa.gz
bash mkt2g_rest.sh Drosophila_melanogaster.BDGP6.28.cdna.all.fa
mv t2g.txt references/fly/
mv Drosophila_melanogaster.BDGP6.28.cdna.all.fa references/fly/

#ftp://ftp.ensembl.org/pub/release-102/fasta/rattus_norvegicus/
wget ftp://ftp.ensembl.org/pub/release-102/fasta/rattus_norvegicus/cdna/Rattus_norvegicus.Rnor_6.0.cdna.all.fa.gz
#mv the fasta file to a directory called: "references/rat/"
mkdir references/rat/
gunzip Rattus_norvegicus.Rnor_6.0.cdna.all.fa.gz
bash mkt2g_rest.sh Rattus_norvegicus.Rnor_6.0.cdna.all.fa
mv t2g.txt references/rat/
mv Rattus_norvegicus.Rnor_6.0.cdna.all.fa references/rat/

#https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-mm10-2020-A.tar.gz
#mv the transcriptome fasta (after generating using mktranscriptome.sh) file to a directory called: "references/mouse/"
mkdir references/mouse/
tar -xvzf refdata-gex-mm10-2020-A.tar.gz
cd refdata-gex-mm10-2020-A
bash ../mktranscriptome.sh
bash ../mkt2g.sh
cd ..
mv refdata-gex-mm10-2020-A/transcriptome.fa references/mouse/
mv refdata-gex-mm10-2020-A/t2g.txt references/mouse/
rm refdata-gex-mm10-2020-A.tar.gz
rm refdata-gex-mm10-2020-A -r

wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
#mv the transcriptome fasta (after generating using mktranscriptome.sh) file to a directory called: "references/human/"
mkdir references/human/
tar -xvzf refdata-gex-GRCh38-2020-A.tar.gz
cd refdata-gex-GRCh38-2020-A
bash ../mktranscriptome.sh
bash ../mkt2g.sh
cd ..
mv refdata-gex-GRCh38-2020-A/transcriptome.fa references/human/
mv refdata-gex-GRCh38-2020-A/t2g.txt references/human/
rm refdata-gex-GRCh38-2020-A.tar.gz
rm refdata-gex-GRCh38-2020-A -r

wget  https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-and-mm10-2020-A.tar.gz
#mv the transcriptome fasta (after generating using mktranscriptome.sh) file to a directory called: "references/human_mouse/"
mkdir references/human_mouse/
tar -xvzf refdata-gex-GRCh38-and-mm10-2020-A.tar.gz
cd refdata-gex-GRCh38-and-mm10-2020-A
bash ../mktranscriptome.sh
bash ../mkt2g.sh
cd ..
mv refdata-gex-GRCh38-and-mm10-2020-A/transcriptome.fa references/human_mouse/
mv refdata-gex-GRCh38-and-mm10-2020-A/t2g.txt references/human_mouse/
rm refdata-gex-GRCh38-and-mm10-2020-A.tar.gz
rm refdata-gex-GRCh38-and-mm10-2020-A -r
