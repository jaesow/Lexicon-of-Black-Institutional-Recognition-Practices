# A Lexicon of Black Institutional Recognition Practices
## HBCU Digital Library Trust Graph Artifact

This folder contains a minimal methodological artifact for Jenaba Sow's Information Studies methods final project.

## Purpose

The artifact prototypes a graph-based relational lexicon for representing Black institutional recognition practices in HBCU archival infrastructure. It models relations of preservation, description, digitization, rights, access, return, stewardship, collaboration, recognition, and memory that are often invisible in conventional citation or bibliography maps.

[Read more about the project](https://www.notion.so/A-Lexicon-of-Black-Institutional-Recognition-Practices-Graph-Modeling-HBCU-Archival-Infrastructure-38090b9a0aa480a78807c8bf5328c1be?source=copy_link)

## Method in one sentence

This is a script-assisted qualitative graph construction pipeline: HBCU Digital Library Trust documentation is transformed into auditable page-level text, candidate relations, normalized nodes, evidence-bearing edges, an expanded relational lexicon, and graph previews for qualitative evaluation.

## Files

- `beyond_citation_hbcu_graph.ipynb`: main computational notebook / data essay.
- `SCHEMA_NOTE.md`: explanation of nodes, edges, relations, relation grounding, and why source-derived verbs are preserved.
- `data/sources.csv`: corpus manifest.
- `data/extracted_pages.csv`: page-level extracted text from source PDFs/web-printouts.
- `data/candidate_edges.csv`: script-assisted evidence windows for possible relations.
- `data/nodes.csv`: normalized graph nodes, with original node types and paper-facing node families.
- `data/edges.csv`: normalized graph edges, with source-grounded relation verbs, relation families, relation grounding, evidence snippets, and interpretive notes.
- `data/lexicon.csv`: expanded relational vocabulary defining every relation used in the edge table.
- `data/node_type_dictionary.csv`: paper-facing node type crosswalk.
- `data/relation_family_dictionary.csv`: relation family summary.
- `outputs/graph_preview.png`: quick NetworkX preview.
- `outputs/validation_report.md`: schema validation summary.
- `scripts/neo4j_import.cypher`: Neo4j import script using the source-grounded relation verbs as relationship types.
- `scripts/neo4j_import_fallback_no_apoc.cypher`: fallback import script if APOC is not available.
- `scripts/validate_graph_schema.py`: validation script for nodes, edges, sources, and lexicon coverage.
- `scripts/extract_text.py`: optional raw PDF extraction script if raw PDFs are placed in `raw/`.

## Schema note: nodes, edges, and relations

This artifact distinguishes between nodes, edges, and relations.

- Nodes are the entities being modeled: institutions, organizations, labor roles, archival materials, metadata objects, infrastructure, platforms, user groups, and concepts.
- Edges are evidence-bearing rows that connect a source node to a target node.
- Relations are the verbs carried by edges. These verbs were chosen intentionally from the source corpus and from interpretive coding of source language.

The goal is not to reduce all relations to a single standardized vocabulary. The goal is to preserve the layered language of the sources while making each modeled relation auditable through source IDs, page numbers, evidence snippets, relation grounding, and interpretive notes.

## Scope note

This artifact is intentionally small. It is a proof of concept, not a comprehensive graph of the HBCU Digital Library Trust or all HBCU knowledge production.
