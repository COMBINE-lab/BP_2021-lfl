cat genes/genes.gtf | awk 'NR>5'| awk '$3=="transcript"' | cut -d$'\t' -f 9 | tr -d ";" | tr -d '\"' | awk '{print $6,$2}' OFS='\t'> t2g.txt
