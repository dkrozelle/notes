library(reutils)
new <- read.delim("./gene_names_from_original.txt", header = FALSE)
new <- as.character(new[,1])

response = sapply(new, FUN = function(gene) {
  
  query = paste(gene, ' AND "Homo sapiens"[porgn:__txid9606]', sep="")
  results = esearch(query, db="Gene")
#   xml <- content(results, "xml")
  return(uid(results)[1])
  }

)
df <- data.frame(names = new, best_uid = response)


# now perform the reverse to verify correct gene
ids <- read.delim("./best_guess.txt", header = FALSE)
ids <- as.numeric(ids[,1])

response2 = sapply(ids, FUN = function(uid) {
  
  if (is.na(uid)) {
    return(list("NA","NA","NA"))
  }
  esum <- esummary(uid, db="gene")
  cont <- content(esum, "parsed")
  return(list(cont[1,1:3]))
}
)


df2 <- data.frame(matrix(unlist(response2), ncol=3, byrow=T))
names(df2) <- c("entrez_id","gene_name","description")
write.table(df2,"./id_verify_lookup_from_entrez.txt", sep="\t", row.names = F)

