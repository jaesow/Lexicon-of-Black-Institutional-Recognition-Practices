import pandas as pd
from pathlib import Path

BASE = Path(__file__).resolve().parents[1]
DATA = BASE / "data"

nodes = pd.read_csv(DATA / "nodes.csv")
edges = pd.read_csv(DATA / "edges.csv")
lexicon = pd.read_csv(DATA / "lexicon.csv")
sources = pd.read_csv(DATA / "sources.csv")

node_ids = set(nodes["node_id"])
relation_terms = set(lexicon["term"])
source_ids = set(sources["source_id"])

errors = []

for _, edge in edges.iterrows():
    if edge["source_node_id"] not in node_ids:
        errors.append(f"Missing source node: {edge['edge_id']} -> {edge['source_node_id']}")

    if edge["target_node_id"] not in node_ids:
        errors.append(f"Missing target node: {edge['edge_id']} -> {edge['target_node_id']}")

    if edge["relationship"] not in relation_terms:
        errors.append(f"Relation not defined in lexicon: {edge['edge_id']} -> {edge['relationship']}")

    if edge["evidence_source_id"] not in source_ids:
        errors.append(f"Evidence source not found: {edge['edge_id']} -> {edge['evidence_source_id']}")

    if pd.isna(edge["evidence_snippet"]) or len(str(edge["evidence_snippet"]).strip()) == 0:
        errors.append(f"Missing evidence snippet: {edge['edge_id']}")

required_edge_fields = [
    "relationship",
    "relationship_category",
    "relation_family",
    "relation_grounding",
    "relation_definition",
    "paper_function",
    "evidence_source_id",
    "evidence_snippet",
]

for field in required_edge_fields:
    if field not in edges.columns:
        errors.append(f"Missing required edge column: {field}")

if errors:
    print("Schema validation failed:")
    for error in errors:
        print(f"- {error}")
else:
    print("Schema validation passed.")
    print(f"Nodes: {len(nodes)}")
    print(f"Edges: {len(edges)}")
    print(f"Relation terms in expanded lexicon: {len(lexicon)}")
    print(f"Sources: {len(sources)}")
    print(f"Node families: {nodes['paper_node_family'].nunique()}")
    print(f"Relation families: {edges['relation_family'].nunique()}")
