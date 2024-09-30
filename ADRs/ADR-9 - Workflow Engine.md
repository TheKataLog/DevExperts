# Status

Approved

Viktor Isaev, Zhivko Angelov, Denis Iudovich, Kiril Stoilov

# Context

We have various business processes in our system, including:

- Resume upload
- Resume submission
- Resume unlocking (with payment processing)
- Interview scheduling

All these processes include several steps, sometimes with matching. Going through these steps takes some time and may 
fail at any moment. The failures may be intermittent (due to the problems with network or hardware) or repeatable (due 
to the bugs in the implementation). We should be able to recover from all types of failures and resume the processing 
from the point where it has failed, and eventually finish every failed processing.

For the above, we need a solution that is:

- Cost efficient
- Robust to failures
- Easy to develop
- Easy to operate

# Decision

We decided to use [AWS Step Functions](https://aws.amazon.com/step-functions/) as a workflow engine for running our 
business processes.

We choose to use AWS Step Functions, because:

- They have all the functionality we need, including branching, durability and recovery from failures, automatic 
retries with increasing backoff, possibility to transfer a message to the dead-letter queue after a certain threshold 
of retries and so on. The pipeline versioning is also supported.
- They let us build a completely serverless solution by using Lambda functions as the processing steps (which reduces 
the costs).
- They are part of AWS and have good integration with other AWS services (which simplifies development), and they let 
us keep the data and processing completely inside our protected infrastructure (which increases security).
- The pipeline can be programmed both with visual editor or a textual code, and they reflect each other. This 
simplifies both development and reading of the pipelines.

As alternatives, we have considered:

- Building the processing pipelines manually by using a robust message broker component (like Apache Kafka or 
RabbitMQ), and handling the messages in service workers. The downsides of this approach are the following:
    - In message brokers like Kafka the messages are being handled sequentially (one-by-one), and if a certain message 
causes a step failure, the processing is unable to move on with the next message by default. We have to explicitly 
program the logic of moving a message to a dead-letter queue or similar approach, and the programming model becomes 
complex and expensive.
    - We will not be able to use serverless processing, because consuming the messages from the broker requires a 
constantly running service which either polls the broker repeatedly or establishes a network connection with the broker 
that should be kept alive.
- Using a ready-made workflow engine like Camunda Zeebe, Temporal, or Apache Airflow. The downsides are:
    - If we choose to deploy this solution by ourselves, we will have additional operating costs and additional bills 
for using cloud resources for the installation.
    - If we choose to use the SaaS variant of any of these services, we may still incur additional costs for the SaaS 
service, additional latency for interacting with the service outside of our main infrastructure (AWS), and additional 
security concerns (the processing pipeline inside the SaaS service will still need to communicate with our 
infrastructure internals where all our workloads would reside).

# Consequences

## Positive

- Our processing pipeline will be completely serverless with all the serverless benefits:
    - Scalability and availability out of the box
    - Simplified programming model: no need to think about timeouts or memory leaks when programming the steps
    - Low costs
- We will have a good choice of languages to develop our pipelines in: Java, Python, JavaScript/TypeScript, Go, Ruby, 
C# - any one that is supported by AWS Lambda, and even multiple ones (though we do not recommend that)

## Negative

- Most of the developers are unfamiliar with AWS Step Functions, and we will have a learning curve

## Reversibility

This is a **one-way decision** that is very difficult to reverse. Changing the workflow engine after it has already 
been implemented is a very tedious and expensive task.