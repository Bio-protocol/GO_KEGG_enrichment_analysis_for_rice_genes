## Step 1.1 Prepare rice gene GO annotation files using public annotation databases.
# A bash script to extract rice genes' GO annotations from RAPDB and OryzaBase, 
# and combine the annotations together into one text file.

# download annotation from RAPDB
wget https://rapdb.dna.affrc.go.jp/download/archive/irgsp1/IRGSP-1.0_representative_annotation_2021-11-11.tsv.gz
gunzip IRGSP-1.0_representative_annotation_2021-11-11.tsv.gz

# extract the annotation information
cat IRGSP-1.0_representative_annotation_2021-11-11.tsv | perl -nale 'my @matches = ($_ =~ m/(GO:\d+)/g); foreach my $go (@matches) {print "$go\t$F[1]";} '| sort -u  > rice_rapdb_go_list.tsv

# download annotation from OryzaBase
# note that the downloaded file's name is 'download?classtag=GENE_EN_LIST',
# but it would be 'OryzabaseGeneListEn_some_date.txt' when downloaded from a browswer
wget https://shigen.nig.ac.jp/rice/oryzabase/gene/download?classtag=GENE_EN_LIST

# extract the annotation information
cat 'download?classtag=GENE_EN_LIST' | cut -f11,16 | grep -v "^\t" | perl -nle 'chomp; my @F=split /\t/, $_; my @id = ($F[0] =~ m/(Os[0-9]{2}g[0-9]{7})/g); my @go = ($F[1] =~ m/(GO:\d+)/g); if (@go>=1){ foreach my $id (@id) {  foreach my $go (@go){ print "$go\t$id" } } }' | sort -u > rice_oryzabase_go_list.tsv

# combine the two annotation files together
cat rice_rapdb_go_list.tsv rice_oryzabase_go_list.tsv | sort -u | perl -nple 'BEGIN {print "go_id\tgene_id";} ' > rice_combined_go_list.tsv
