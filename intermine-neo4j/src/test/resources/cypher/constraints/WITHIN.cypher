MATCH (gene :Gene),
(gene)-[gene_chromosomelocation:LOCATED_ON]-(),
(gene)-[:PARTICIPATES_IN]-(gene_pathways :Pathway)
WHERE (gene_chromosomelocation.start >= 12345 AND gene_chromosomelocation.end <= 45678 AND ()-[gene_chromosomelocation]-(:Chromosome {primaryIdentifier:'X'})) OR (gene_chromosomelocation.start >= 12345 AND gene_chromosomelocation.end <= 45678 AND ()-[gene_chromosomelocation]-(:Chromosome {primaryIdentifier:'2L'})) OR (gene_chromosomelocation.start >= 12345 AND gene_chromosomelocation.end <= 12345 AND ()-[gene_chromosomelocation]-(:Chromosome {primaryIdentifier:'3R'}))
RETURN gene.symbol,
gene_pathways.identifier

