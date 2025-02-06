import { StringOutputParser } from "@langchain/core/output_parsers";
import { PromptTemplate } from "@langchain/core/prompts";
import { RunnableSequence } from "@langchain/core/runnables";
import { BaseLanguageModel } from "langchain/base_language";

// tag::interface[]
export interface GenerateAnswerInput {
  question: string;
  context: string;
}
// end::interface[]

// tag::function[]
export default function initGenerateAnswerChain(
  llm: BaseLanguageModel
): RunnableSequence<GenerateAnswerInput, string> {
  // TODO: Create a Prompt Template
  const answerQuestionPrompt = PromptTemplate.fromTemplate(`
    Use only the following context to answer the following question.

    Question:
    {question}

    Context:
    {context}

    * Whenever you are asked a question about the kind of input or output data is required or depended on, 
    you must also interpret the datatype and return the type or input or output data as a string property.
      * For example if the input data includes the extension .xlsx or .xls files, 
      you must interpret the data type as "Excel".
      * If it is a URL or link with the substring 'sharepoint' in it, 
        you must interpret the data type as "Sharepoint URL".
      * If you cannot determine the data type, return the input data field.

    Answer as if you have been asked the original question.
    Do not use your pre-trained knowledge.

    If you don't know the answer, just say that you don't know, don't try to make up an answer.
    Include links and sources where possible.
  `);
  // TODO: Return a RunnableSequence
  return RunnableSequence.from<GenerateAnswerInput, string>([
    answerQuestionPrompt,
    llm,
    new StringOutputParser(),
  ]);
}
// end::function[]

/**
 * How to use this chain in your application:

// tag::usage[]
const llm = new OpenAI() // Or the LLM of your choice
const answerChain = initGenerateAnswerChain(llm)

const output = await answerChain.invoke({
  input: 'Who is the CEO of Neo4j?',
  context: 'Neo4j CEO: Emil Eifrem',
}) // Emil Eifrem is the CEO of Neo4j
// end::usage[]
 */
