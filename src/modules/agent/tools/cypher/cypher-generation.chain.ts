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
  about an Arduino project and its components.
  Convert the user's question into a Cypher statement based on the schema.

  You must:
  * Only use the nodes, relationships and properties mentioned in the schema.
  * When required, \`IS NOT NULL\` to check for property existence, and not the exists() function.
  * Use the \`elementId()\` function to return the unique identifier for a node or relationship as \`_id\`.
    For example:
    \`\`\`
    MATCH (arduino:Controller)-[:CONTROLS]->(buzzer:Sensor)
    WHERE buzzer.name = 'Active Buzzer'
    RETURN  elementId(arduino) AS _id, arduino.name AS Controller, buzzer.name AS Sensor
    \`\`\`
  * Include extra information about the nodes that may help an LLM provide a more informative answer,
    for example power and resistance rating.
  * Limit the maximum number of results to 10.
  * Respond with only a Cypher statement.  No preamble.


  Example Question: What are all the events triggered by the Arduino Nano and the sensors that triggered them?
  Example Cypher:
  MATCH (arduino:Controller)<-[:SENDS_DATA_TO]-(sensor:Sensor)
  MATCH (sensor:Sensor)-[:DETECTS]->(condition:Condition)-[:CAUSES]->(event:Event)
  RETURN elementId(event) AS _id, event.createdAt, event.name AS EventName, sensor.name AS SensorName;

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
