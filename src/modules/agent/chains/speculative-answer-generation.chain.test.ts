import { config } from "dotenv";
import initGenerateAnswerChain from "./answer-generation.chain";
import { BaseChatModel } from "langchain/chat_models/base";
import { RunnableSequence } from "@langchain/core/runnables";
import { ChatOpenAI } from "@langchain/openai";
import { PromptTemplate } from "@langchain/core/prompts";
import { StringOutputParser } from "@langchain/core/output_parsers";

describe("Speculative Answer Generation Chain", () => {
  let llm: BaseChatModel;
  let chain: RunnableSequence;
  let evalChain: RunnableSequence<any, any>;

  beforeAll(async () => {
    config({ path: ".env.local" });

    llm = new ChatOpenAI({
      openAIApiKey: process.env.OPENAI_API_KEY,
      modelName: "gpt-4o-mini",
      temperature: 0,
      configuration: {
        baseURL: process.env.OPENAI_API_BASE,
      },
    });

    chain = await initGenerateAnswerChain(llm);

    // tag::evalchain[]
    evalChain = RunnableSequence.from([
      PromptTemplate.fromTemplate(`
        Does the following response answer the question provided?

        Question: {question}
        Response: {response}

        Respond simply with "yes" or "no".
      `),
      llm,
      new StringOutputParser(),
    ]);
    // end::evalchain[]
  });

  describe("Simple RAG", () => {
    it("should use context to answer the question", async () => {
      const question = "What controller is being used in this arduino project?";
      const response = await chain.invoke({
        question,
        context: '[{name: "Arduino Nano"}]',
      });

      // tag::eval[]
      const evaluation = await evalChain.invoke({ question, response });

      expect(`${evaluation.toLowerCase()} - ${response}`).toContain("yes");
      // end::eval[]
    });

    it("should refuse to answer if information is not in context", async () => {
      const question = "What company created the Arduino Nano?";
      const response = await chain.invoke({
        question,
        context:
          "[{name: 'Arduino Uno'}, {name: 'Arduino Mega'}, {name: 'Arduino Pro Mini'}]",
      });

      const evaluation = await evalChain.invoke({ question, response });
      expect(`${evaluation.toLowerCase()} - ${response}`).toContain("no");
    });

  
  });
});
