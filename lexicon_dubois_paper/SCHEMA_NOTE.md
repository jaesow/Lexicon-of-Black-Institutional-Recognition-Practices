# Schema Note: Nodes, Edges, and Relations

This artifact preserves the source-grounded vocabulary that emerged from the HBCU Digital Library Trust corpus. It does not collapse the graph into a generic ontology. The paper's central claim is that the relation verbs themselves are part of the methodology.

## Distinction used in the paper

- **Nodes** are the entities being modeled: institutions, organizations, labor roles, archival materials, metadata objects, platforms, user groups, rights structures, and concepts.
- **Edges** are evidence-bearing rows that connect a source node to a target node.
- **Relations** are the verbs carried by edges. They are interpretive claims grounded in the source corpus.

## Why the relation verbs are not standardized away

The relation verbs were chosen from the sources and from close interpretive coding of source language. Some preserve workflow language, such as `SCANS`, `QUALITY_CHECKS`, `UPLOADS_TO`, and `RETURNS_TO`. Some preserve mission or value language, such as `BUILDS_CAPACITY_WITH`, `PRESERVES`, `SUSTAINS`, and `ACKNOWLEDGES_AND_CELEBRATES`. Others translate metadata, rights, and research access practices into graph form, such as `DESCRIBE`, `LINK_COMMONALITY_ACROSS`, `RETAINS_OWNERSHIP_OF`, and `PROVIDES_ACCESS_TO`.

The goal is not to reduce all relations to a cleaner controlled vocabulary. The goal is to preserve the layered language of the sources while making each modeled relation auditable through source IDs, page numbers, evidence snippets, relation grounding, and interpretive notes.

## New paper-aligned fields

The enhanced `edges.csv` preserves the original `relationship` and `relationship_category` columns, then adds:

- `relation_family`: a paper-facing analytic family for the relation.
- `relation_grounding`: the source-language basis for the relation, such as mission language, workflow language, metadata language, rights language, or research access language.
- `relation_definition`: a short definition of the relation as used in the model.
- `paper_function`: why the relation matters for the paper's argument about citation, infrastructure, and Black knowledge production.
- `relation_status`: a quick indication that the relation is source-grounded or interpretive-source-grounded.

The enhanced `nodes.csv` preserves the original `node_type`, then adds:

- `paper_node_family`: a broader paper-facing node family.
- `paper_node_note`: a short explanation of why this kind of node matters for the method.

The expanded `lexicon.csv` now includes every relation used in `edges.csv`, so the relational vocabulary remains accountable to the graph data.
