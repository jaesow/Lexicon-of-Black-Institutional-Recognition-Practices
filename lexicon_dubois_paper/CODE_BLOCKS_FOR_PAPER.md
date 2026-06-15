# Code Blocks and Captions for the Paper

Use the labels **Code Block 1** and **Code Block 2**, not "Listing."

## Code Block 1. Page-level text extraction

Caption: **Code Block 1. Page-level text extraction.** This script extracts page-level text from the source corpus and preserves source IDs, titles, filenames, page numbers, and text fields so that graph relations can remain auditable.

```python
from pathlib import Path
import re
import pandas as pd
import fitz

base = Path(__file__).resolve().parents[1]
data = base / "data"
raw = base / "raw"
sources = pd.read_csv(data / "sources.csv")
rows = []

for _, src in sources.iterrows():
    pdf_path = raw / src["filename"]
    if not pdf_path.exists():
        continue
    doc = fitz.open(str(pdf_path))
    for i, page in enumerate(doc, start=1):
        text = re.sub(r"\s+", " ", page.get_text("text") or "").strip()
        rows.append({
            "source_id": src["source_id"],
            "title": src["title"],
            "filename": src["filename"],
            "page": i,
            "text": text
        })

pd.DataFrame(rows).to_csv(data / "extracted_pages.csv", index=False)
```

## Code Block 2. Neo4j import script for source-grounded relations

Caption: **Code Block 2. Neo4j import script for source-grounded relations.** This script imports the node and edge tables into Neo4j while preserving the source-derived relation verbs, relation families, relation grounding, and evidence snippets that make each edge auditable.

```cypher
CREATE CONSTRAINT entity_id IF NOT EXISTS
FOR (n:Entity) REQUIRE n.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
MERGE (n:Entity {id: row.node_id})
SET n.name = row.name,
    n.node_type = row.node_type,
    n.paper_node_family = row.paper_node_family,
    n.description = row.description,
    n.evidence_source_id = row.evidence_source_id;

LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
MATCH (s:Entity {id: row.source_node_id})
MATCH (t:Entity {id: row.target_node_id})
CALL apoc.create.relationship(s, row.relationship, {
    edge_id: row.edge_id,
    relation_family: row.relation_family,
    relation_grounding: row.relation_grounding,
    evidence_source_id: row.evidence_source_id,
    evidence_page: row.evidence_page,
    evidence_snippet: row.evidence_snippet,
    interpretive_note: row.interpretive_note
}, t) YIELD rel
RETURN count(rel) AS source_grounded_relations_created;
```
