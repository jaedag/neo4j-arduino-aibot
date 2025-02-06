
MATCH (n)
DETACH DELETE n;


LOAD CSV WITH HEADERS FROM "file:///sample-work.csv" AS row
MERGE (design:Design {id: randomUUID(), name: row.Design})
MERGE (focusArea:FocusArea {id: randomUUID(), name: row.`Focus Area`})
MERGE (user:User {id: randomUUID(), name: row.`User Name`})

CREATE (workflow:Workflow {
  id: randomUUID(),
  status: row.Status,
  inputData: row.`Input Data`,
  outputData: row.`Output Data`,
  name: row.Workflow,
  details: row.Details,
  adminComments: row.`Admin Comments`,
  reviewedBy: row.`Reviewed By`,
  createdAt: datetime(),
  lastEdited: datetime(row.`Last Edited`)
})
MERGE (focusArea)-[:HAS_DESIGN]->(design)
MERGE (workflow)-[:HAS_FOCUS_AREA]->(focusArea)
MERGE (workflow)-[:SUBMITTED_BY]->(user)

RETURN workflow, focusArea, design, user;

