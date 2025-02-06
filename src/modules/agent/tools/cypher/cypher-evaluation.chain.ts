import { BaseLanguageModel } from "langchain/base_language";
import { PromptTemplate } from "@langchain/core/prompts";
import {
  RunnablePassthrough,
  RunnableSequence,
} from "@langchain/core/runnables";
import { JsonOutputParser } from "@langchain/core/output_parsers";

// tag::interface[]
export type CypherEvaluationChainInput = {
  question: string;
  cypher: string;
  schema: string;
  errors: string[] | string | undefined;
};
// end::interface[]

// tag::output[]
export type CypherEvaluationChainOutput = {
  cypher: string;
  errors: string[];
};
// end::output[]

// tag::function[]
export default async function initCypherEvaluationChain(
  llm: BaseLanguageModel
) {
  // TODO: Create prompt template
  const prompt = PromptTemplate.fromTemplate(`
  You are an expert Neo4j Developer evaluating a Cypher statement written by an AI.

  Check that the cypher statement provided below against the database schema to check that
  the statement will answer the user's question.
  Fix any errors where possible.

  The query must:
  * Only use the nodes, relationships and properties mentioned in the schema.
  * Assign a variable to nodes or relationships when intending to access their properties.
  * Use \`IS NOT NULL\` to check for property existence.
  * Use the \`elementId()\` function to return the unique identifier for a node or relationship as \`_id\`.
    For example "The 39 Steps" becomes "39 Steps, The" or "the matrix" becomes "Matrix, The".
  * Limit the maximum number of results to 10.
  * Respond with only a Cypher statement.  No preamble.

  Respond with a JSON object with "cypher" and "errors" keys.
    * "cypher" - the corrected cypher statement
    * "corrected" - a boolean
    * "errors" - A list of uncorrectable errors.  For example, if a label,
        relationship type or property does not exist in the schema.
        Provide a hint to the correct element where possible.

  Fixable Example #1:
  * cypher:
      MATCH (workflow:Workflow)-[:HAS_FOCUS_AREA]->(focusArea:FocusArea)
      RETURn workflow.name AS WorkflowName, focusArea.name AS FocusAreaName, r.description LIMIT 10
  * errors: ["Variable \`r\` not defined (line 1, column 172 (offset: 171))"]
  * response:
      MATCH (workflow:Workflow)-[r:HAS_FOCUS_AREA]->(focusArea:FocusArea)
      RETURN workflow.name AS WorkflowName, focusArea.name AS FocusAreaName LIMIT 10

  Schema:
  {schema}

  Question:
  {question}

  Cypher Statement:
  {cypher}

  {errors}
`);


  // TODO: Return runnable sequence
  return RunnableSequence.from<
  CypherEvaluationChainInput,
  CypherEvaluationChainOutput
>([
  RunnablePassthrough.assign({
    // Convert errors into an LLM-friendly list
    errors: ({ errors }) => {
      if (
        errors === undefined ||
        (Array.isArray(errors) && errors.length === 0)
      ) {
        return "";
      }

      return `Errors: * ${
        Array.isArray(errors) ? errors?.join("\n* ") : errors
      }`;
    },
  }),
  prompt,
  llm,
  new JsonOutputParser<CypherEvaluationChainOutput>(),
]);
}
// end::function[]
