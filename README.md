## This repository is a copy of https://github.com/pachterlab/BP_2021 with the modifications described in "A like-for-like comparison of lightweight-mapping pipelines for single-cell RNA-seq data pre-processing".  The original repository corresponds to the preprint "Benchmarking of lightweight-mapping based single-cell RNA-seq pre-processing " by A. Sina Booeshaghi and Lior Pachter.

## How to run the pipeline

***Note: All the addresses are relative to the main directory of the repository.***

#### Create the following directories in the main directory of the repository
- navigate to `./analysis/scripts`
- Run `$bash make_dirs.sh`

#### Download cellranger barcodes
- navigate to `./analysis/scripts`
- Run `$bash gather_cr_barcodes.sh`

#### Download the samples
- Make sure you have the **sratools 2.9** is installed on your system (https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.6/sratoolkit.2.9.6-ubuntu64.tar.gz)
- navigate to `./analysis/scripts/`
- Run `$bash gather_data.sh`
  Downloads the fastq files and moves the ones for each sample to a directory called `samples/{species}-{sample-name}`

#### Download the references
- Make sure **'bamtofastq'** is downloaded and added to the PATH ((https://github.com/10XGenomics/bamtofastq)
- navigate to `./analysis/scripts/`
- Run `$bash gather_refs.sh`
  This script, for human, mouse and human_mouse, uses the `.mktranscriptome.sh` to build the transcriptome from the genome and the annotation files, and use the `mkt2g.sh` to generate the gene-to-transcript files. For other references, it uses `mkt2g_rest.sh` to generate the gene-to-transcript files. Then, the fasta file and the corresponding t2g file for each species are moved to a directory called `references/{species}/`

#### Add the relavent paths to the config file: 

- The configuration file is the JSON file : `analysis/scripts/config_all.json`
    The JSON files for the samples you wish to process should be located at a directory and the path of the directory should be provided in `config_all.json`. The JSON files should be similar to the ones located at `./analysis/scripts/configs/`

#### Prepare the results with both pipelines (kallisto-bustools and alevin-fry)
- navigate to `./analysis/scripts/`
- Run `$./make_indices.sh PATH/TO/CONFIG`
- Run `$./run_all_salmon.sh PATH/TO/CONFIG`
- Run `$./run_all_kallisto.sh PATH/TO/CONFIG`

#### Generate the time and memory comparison plots
- Set the config file's path to the `config_all` variable
- Execute all the commands in the **memtime** notebook: `./analysis/notebooks/memtime.ipynb`

#### Generate the gene count comparison plots
Make sure the results for all the samples generated by both tools are located at `./data/kallisto_out` and `./data/salmon_out`
* Prepare the data for plotting gene set enrichment analysis
	* Make sure the Seurat version 4.0 and othe required R packages are installed
	* navigate to the `./analysis/notebooks/` directory
	* Run `$Rscript run_gsea_bar_full.R`
* Load the data for making the plots
	* navigate to the `./analysis/scripts/`
	* Run `$python mkdata.py -d sample_name -o plotting/output/for/the/sample`
* Generate all the plots
	* Run `$python mkplot.py -d sample_name -i plotting/output/for/the/sample -o output/dir/`
