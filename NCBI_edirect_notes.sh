# EDirect is a series of unix commandline tools that act as wrappers for a traditional NCBI E-util Entrez query.  
# make sure you use version >4.4 since NCBI now requires https

# be a good person, start every session by identifying yourself
econtact -email name@gmail.com

esearch -db gene -query "npc1 AND 9606[TID]"

# to get a list of search fields for a given db you can use the einfo tool, or my script
display_db_search_fields.sh

#esearch returns an ENTREZ_DIRECT esearch object
<ENTREZ_DIRECT>
  <Db>gene</Db>
  <WebEnv>NCID_1_52742048_130.14.18.34_9001_1454937040_957792720_0MetA0_S_MegaStore_F_1</> <WebEnv>
  <QueryKey>1</QueryKey>
  <Count>39</Count>
  <Step>1</Step>
</ENTREZ_DIRECT>

# you can parse the query count before proceeding
esearch -db gene -query "npc1[PREF] AND 9606[TID]" | \
  xtract -pattern ENTREZ_DIRECT -element Count
> 1

#to get the actual data, you need to efetch and request a specific format.
# These formats are db specific. The easiest way to determine format types is by performing a search on the ncbi website. 
# while you'd think 'gene' is a type of sequence, it doesn't work with fasta/acc/gb/gp formats. you'd probably need to perform an elink query of linked nucleotide sequences but I haven't figured out how to do this yet.
#gene db can use
#	-format docsum, tabular, xml, asn.1, uid, url

#You can also store the esearch result and call back to multiple functions
esearch -db protein -query "npc1[PREF] AND 9606[TID]" >x
 cat x |xtract -pattern ENTREZ_DIRECT -element Count
 cat x |efetch -format fasta
 cat x |efetch -format docsum

# if you have an id, you can directly fetch without an esearch
efetch -db gene -id 4864 

# In order to extract values from xml fields you can use the `xtract` function
# outline and synopsis arguments provide a nice summary of the xml structure
efetch -db protein -id 26418308 -format xml|xtract -synopsis |head
> Bioseq-set
> Bioseq-set/Bioseq-set_seq-set
> Bioseq-set/Bioseq-set_seq-set/Seq-entry
> Bioseq-set/Bioseq-set_seq-set/Seq-entry/Seq-entry_set
> Bioseq-set/Bioseq-set_seq-set/Seq-entry/Seq-entry_set/Bioseq-set

efetch -db protein -id 26418308 -format xml|xtract -outline |head
> Bioseq-set
>   Bioseq-set_seq-set
>     Seq-entry
>       Seq-entry_set
>         Bioseq-set

# there is a rich set of subsetting and selecting arguments available for xtract

xtract
  -pattern <LABEL> # is used to select a root level of the structure, typically the top
  -element <LABEL> # specify the specific element (or set) that you want text data from. If the elment has children nodes, it will return the entire tree below your specified point
  -block <GROUP LABEL> 
    # this allows you to extract multiple elements from a logical block group without specifying an entire tree for each, you'd need to specify -element below this group
    # in place of block, a full set of XML level-based organization commands, in order of rank, are:
  -pattern -division -group -branch -block -section -subset -unit

# entrezgene_lookup.sh npc1
4864  NPC1  NPC intracellular cholesterol transporter 1 NPC

# example script to fetch 
if [ $1 != "#N/A" ]; then
  echo "test" |\
  esearch -db gene -query "($1) AND 9606[TID]" | \
  efetch -format docsum | \
  xtract -pattern DocumentSummary -element Id Name #Description OtherAliases
else
  echo $1
fi
