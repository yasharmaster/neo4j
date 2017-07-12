MATCH (gene :Gene),
(gene)-[]-(gene_goannotation :goAnnotation),
(gene_goannotation)-[]-(gene_goannotation_evidence :evidence),
(gene_goannotation_evidence)-[]-(gene_goannotation_evidence_code :code),
(gene_goannotation)-[]-(gene_goannotation_ontologyterm :ontologyTerm),
(gene)-[]-(gene_organism :organism)
OPTIONAL MATCH (gene_goannotation_evidence)-[]-(gene_goannotation_evidence_with :with)
WHERE gene_goannotation_evidence_code.code = 'IPI' AND gene_goannotation_ontologyterm.name = 'protein binding' AND gene_organism.name = 'Drosophila melanogaster' AND ( ANY (key in keys(gene) WHERE gene[key]='notch') AND (gene)-[]-(Organism { shortName: 'D. melanogaster' } )) AND gene_goannotation_ontologyterm.namespace = 'cellular_component'
RETURN gene.primaryIdentifier,
gene.symbol,
gene_goannotation_ontologyterm.identifier,
gene_goannotation_ontologyterm.name,
gene_goannotation_evidence_code.code,
gene_goannotation_evidence_with.primaryIdentifier
ORDER BY gene.primaryIdentifier ASC
