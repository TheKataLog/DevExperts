# Status

Approved

Zhivko Angelov, Viktor Isaev, Denis Iudovich, Kiril Stoilov

# Context

During the requirements analysis phase we have identified various architecture characteristics, including scalability, 
availability, extensibility, data integrity, security, and workflow. After various discussion sessions, the team agreed 
that the most crucial characteristics are:

- Scalability
- Extensibility
- Data integrity

In addition, we had to take into consideration the tight budget constraints of the non-profit organization.

Given the above, we need to choose the high-level architectural style to use in our design.

# Decision

Based on the identified top architecture characteristics and with the help of the Architecture Styles Worksheet, we 
decided that **event-driven architecture** best fits those characteristics.

The event-driven architecture is a distributed asynchronous architecture pattern. It is a suitable architecture of 
choice, when the system requires high scalability and performance, when it is expected to constantly evolve, and when 
it involves a lot of asynchronous processing.

We chose event-driven architecture over micro-service architecture, which also has a high score on most of the 
characteristics, because event-driven architecture is more cost effective and more suitable for workflow design.

# Consequences

## Positive

Using event-driven architecture, we will achieve:

- Scalability - the system can scale horizontally to handle the increased number of users, resumes, and job posts.
- Extensibility - the system can adapt new features, LLM models and integrations with external systems without major 
impact on the design.
- Fault tolerance - the system could be up and running even when some of the components are down, e.g. failed 
asynchronous AI processing will not affect user registration, resume uploading or job posting.
- Workflow - the system allows us to easily design various workflow processes around resume processing and candidates 
matching.

## Negative

Using event-driven architecture, we will have the following challenges:

- Complexity - the system will require skills and expertise for development of asynchronous communication.
- Maintainability - the system will require robust logging and monitoring of the event flows.

## Reversibility

This is a **one-way decision** which is very difficult to change afterwards. Switching to another architectural style 
basically means starting a new project. Hybrid approach is probably possible, but is not recommended due to increased 
complexity.

# See also

- [https://coda.io/d/_dF0G5Ugnocr/_suW4e](https://coda.io/d/_dF0G5Ugnocr/_suW4e)