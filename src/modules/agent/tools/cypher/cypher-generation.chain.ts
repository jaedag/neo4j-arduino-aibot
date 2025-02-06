import { BaseLanguageModel } from "langchain/base_language";
import { PromptTemplate } from "@langchain/core/prompts";
import {
  RunnablePassthrough,
  RunnableSequence,
} from "@langchain/core/runnables";
import { StringOutputParser } from "@langchain/core/output_parsers";
import { Neo4jGraph } from "@langchain/community/graphs/neo4j_graph";

// tag::function[]
export default async function initCypherGenerationChain(
  graph: Neo4jGraph,
  llm: BaseLanguageModel
) {
  // TODO: Create Prompt Template
  // Create Prompt Template
  const cypherPrompt = PromptTemplate.fromTemplate(`
  You are a Neo4j Developer translating user questions into Cypher to answer questions
  about an workflows in an organisation.
  Convert the user's question into a Cypher statement based on the schema.

  You must:
  * Only use the nodes, relationships and properties mentioned in the schema.
  * When required, \`IS NOT NULL\` to check for property existence, and not the exists() function.
  * Use the \`elementId()\` function to return the unique identifier for a node or relationship as \`_id\`.
    For example:
    \`\`\`
    MATCH (workflow:Workflow)-[:HAS_FOCUS_AREA]->(focusArea:FocusArea)
    WHERE workflow.details CONTAINS "RVP"
    RETURN  elementId(workflow) AS _id, workflow.name AS WorkflowName, focusArea.name AS FocusAreaName;
    \`\`\`
  * Include extra information about the nodes that may help an LLM provide a more informative answer,
    for example name, details, input data, description, etc.
  * Whenever you are describing workflows, designs, focus areas or users, make sure to return the name of the node.
  * Whenever you are asked a question about the kind of input or output data, 
    you must also interpret the datatype and return the type or input or output data as a string property.
    * For example if the input data includes the extension .xlsx or .xls files, 
    you must interpret the data type as "Excel".
    * If it is a URL or link with the substring 'sharepoint' in it, 
      you must interpret the data type as "Sharepoint URL".
    * If you cannot determine the data type, return the input data field.
    * If it is a file with the extension .brd, you must interpret the data type as "BRD File".
  * Whenever searching within string, use the toLower() function to make the search case-insensitive.
  * Whenever searching a multi-word string, split the string into individual words
    and do a string comparison on each word.
    For example, "Electrical Design Guide" should be split into "Electrical", "Design", and "Guide"
    and each word should be used in the comparison.
  * The word "related" should be interpreted as either a relationship or a property search.
  * Respond with only a Cypher statement.  No preamble.

  Example Question: Workflows related to platform hardware design
  Example Cypher:
  MATCH (workflow:Workflow)-[:HAS_FOCUS_AREA]->(focusArea:FocusArea)-[:HAS_DESIGN]->(design:Design)
  WHERE 
  toLower(workflow.name + " " + workflow.details + " " + focusArea.name + " " + design.name) 
  CONTAINS toLower("platform")
  OR toLower(workflow.name + " " + workflow.details + " " + focusArea.name + " " + design.name)
  CONTAINS toLower("hardware")

  RETURN elementId(workflow) AS _id, workflow.createdAt, workflow.name AS WorkflowName,
  workflow.details AS WorkflowDetails, focusArea.name AS FocusAreaName, design.name AS DesignName;

  Example Question: Workflows related to Electrical Design Guide
  Example Cypher:
  MATCH (workflow:Workflow)-[:HAS_FOCUS_AREA]->(focusArea:FocusArea)-[:HAS_DESIGN]->(design:Design)
  WHERE 
  toLower(workflow.name + " " + workflow.details + " " + focusArea.name + " " + design.name) 
  CONTAINS toLower("Electrical")
  OR toLower(workflow.name + " " + workflow.details + " " + focusArea.name + " " + design.name)
  CONTAINS toLower("Design")
  OR toLower(workflow.name + " " + workflow.details + " " + focusArea.name + " " + design.name)
  CONTAINS toLower("Guide")

  RETURN elementId(workflow) AS _id, workflow.createdAt, workflow.name AS WorkflowName,
  workflow.details AS WorkflowDetails, focusArea.name AS FocusAreaName, design.name AS DesignName;


  Example Question: What workflows are related to N-1 interposer design?
  Example Cypher:
  MATCH (workflow:Workflow)-[:HAS_FOCUS_AREA]->(focusArea:FocusArea)-[:HAS_DESIGN]->(design:Design)
  WHERE toLower(workflow.name) CONTAINS toLower("N-1 interposer design")
  OR toLower(workflow.details) CONTAINS toLower("N-1 interposer design")
  OR toLower(focusArea.name) CONTAINS toLower("N-1 interposer design")
  OR toLower(design.name) CONTAINS toLower("N-1 interposer design")

  RETURN elementId(workflow) AS _id, workfow.createdAt, workflow.name AS WorkflowName, 
  workflow.details AS WorkflowDetails, focusArea.name AS FocusAreaName, design.name AS DesignName;

  Example Question: What kind of input data is required for a Demand Management workflow?
  Example Cypher:
  MATCH (workflow:Workflow)-[:HAS_FOCUS_AREA]->(focusArea:FocusArea)
  WHERE toLower(workflow.name) CONTAINS toLower("Demand Management")

  RETURN elementId(workflow) AS _id, workflow.name AS WorkflowName,
  workflow.inputData AS InputData, workflow.outputData AS OutputData;

  Schema:
  {schema}

  Question:
  {question}

`);
  // TODO: Create the runnable sequence
  return RunnableSequence.from<string, string>([
    {
      // Take the input and assign it to the question key
      question: new RunnablePassthrough(),
      // Get the schema
      schema: () => graph.getSchema(),
    },  cypherPrompt,
    llm,
    new StringOutputParser(),
  ]);
}
// end::function[]
