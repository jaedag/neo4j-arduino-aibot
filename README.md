# Neo4j Arduino Chatbot Case Study

## Overview

This project demonstrates how Neo4j can model and analyze relationships in Arduino-based systems. By integrating Neo4j with a chatbot, users can query their Arduino project data, discover patterns, and troubleshoot setups using natural language.

## Key Features

- **Conversational Interface:** Ask questions about components, connections, and data.
- **Dynamic Cypher Generation:** Chatbot translates questions into Cypher queries for Neo4j.
- **Rich Insights:** Get details like component status, wiring, sensor readings, and trends.
- **Relationship Exploration:** Visualize how sensors, actuators, and controllers interact.
- **Troubleshooting:** Diagnose issues by tracing dependencies in the graph.
- **Scalable Knowledge Base:** Add new devices, firmware, or experiment results easily.

## Example Use Cases

- _"What is the current reading from the temperature sensor in Lab 2?"_
- _"Which actuators are controlled by the main Arduino board?"_
- _"Why is the LED not turning on when the button is pressed?"_
- _"Show me the average humidity readings for the past week."_
- _"List all sensors connected to the greenhouse monitoring system."_

## How It Works

1. **User Input:** User asks a question about their Arduino system.
2. **Prompt-Driven Cypher Generation:** Chatbot converts the question into a Cypher query.
3. **Query Execution:** Cypher runs on Neo4j.
4. **Insightful Response:** Chatbot returns the answer, often with extra context.

## Prompt Engineering

Prompts ensure:
- Only schema nodes/relationships/properties are used
- `IS NOT NULL` for property checks
- `elementId()` for unique IDs
- Extra info (timestamps, readings, locations) included
- Results are limited for clarity
- Responses are Cypher statements only

## Project Structure

- `cypher/` — Cypher scripts for Arduino system and queries
- `prompts/` — Prompt templates for Cypher and chatbot
- `src/` — Application code, chatbot logic, Neo4j integration

## Potential Applications

- **IoT Monitoring:** Real-time sensor/device insights
- **STEM Education:** Interactive electronics learning
- **Lab Management:** Track experiments and results
- **Smart Environments:** Manage home automation or greenhouses
- **Efficiency:** Identify bottlenecks or failures
- **R&D:** Analyze data from experiments or prototypes
- **Visualization:** Graph relationships and data flows
- **Historical Analysis:** Track changes, identify trends
- **Predictive Maintenance:** Use data to predict failures

## Conclusion

Neo4j and a chatbot interface unlock deep insights from connected Arduino systems. This approach is adaptable to any domain where understanding relationships and data flow is critical.

---

## Files to Edit for your dataset

cypher-generation-chain.ts
cypher-retrieval-chain.ts
cypher-evaluation-chain.ts