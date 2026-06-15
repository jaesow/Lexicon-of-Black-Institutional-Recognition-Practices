// Fallback Neo4j import script if APOC is not available.
// This preserves the source-grounded relation verb as a property instead of a relationship type.

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
MERGE (s)-[r:SOURCE_GROUNDED_RELATION {edge_id: row.edge_id}]->(t)
SET r.relationship = row.relationship,
    r.relationship_category = row.relationship_category,
    r.relation_family = row.relation_family,
    r.relation_grounding = row.relation_grounding,
    r.relation_definition = row.relation_definition,
    r.paper_function = row.paper_function,
    r.evidence_source_id = row.evidence_source_id,
    r.evidence_page = row.evidence_page,
    r.evidence_snippet = row.evidence_snippet,
    r.interpretive_note = row.interpretive_note;

// Preview query:
// MATCH p=(a)-[r:SOURCE_GROUNDED_RELATION]->(b) RETURN p LIMIT 75;

MATCH p=(a)-[r]->(b)
WHERE a.visual_layer = true
  AND b.visual_layer = true
  AND type(r) IN [
    "ACCESS_USE",
    "CAPACITY",
    "COLLABORATION",
    "METADATA_DESCRIPTION",
    "RIGHTS_RETURN",
    "STEWARDSHIP_MEMORY",
    "WORKFLOW_CARE"
  ]
RETURN p
LIMIT 75;