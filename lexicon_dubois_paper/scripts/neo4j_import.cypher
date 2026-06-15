// Neo4j import script for the paper-aligned relational lexicon model.
// Put data/nodes.csv and data/edges.csv in the Neo4j import directory first.
// This version requires APOC so source-grounded relation verbs can become relationship types.

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
    relationship_category: row.relationship_category,
    relation_family: row.relation_family,
    relation_grounding: row.relation_grounding,
    relation_definition: row.relation_definition,
    paper_function: row.paper_function,
    evidence_source_id: row.evidence_source_id,
    evidence_page: row.evidence_page,
    evidence_snippet: row.evidence_snippet,
    interpretive_note: row.interpretive_note
}, t) YIELD rel
RETURN count(rel) AS source_grounded_relations_created;

// Preview query:
// MATCH p=(a)-[r]->(b) RETURN p LIMIT 75;
