grep '>' $1 | cut -f1,4 -d$' ' | awk '{split($1,a,">");split($2,b,":"); print a[2],b[2]}' OFS='\t' > t2g.txt
