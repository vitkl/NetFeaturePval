library(roxygen2)
library(devtools)
document()
install()

pkgdown::build_site()

data = fread("../data/viral_human_net_w_domains", sep = "\t", stringsAsFactors = F)

# testing alternative method to calculate empirical p-value for count of domains per viral protein
library(igraph)

prot2domain = as_adjacency_matrix(graph.data.frame(unique(data[, .(IDs_interactor_human, IDs_domain_human)])))
prot2domain = prot2domain[rownames(prot2domain) %in% data$IDs_interactor_human,
                          colnames(prot2domain) %in% data$IDs_domain_human]

viral2human = as_adjacency_matrix(graph.data.frame(unique(data[, .(IDs_interactor_viral, IDs_interactor_human)])))
viral2human = viral2human[rownames(viral2human) %in% data$IDs_interactor_viral,
                          colnames(viral2human) %in% data$IDs_interactor_human]

viral2human %*% prot2domain
