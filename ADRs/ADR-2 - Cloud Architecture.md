# Status

Approved

Kiril Stoilov, Zhivko Angelov, Viktor Isaev

# Context

We are designing an HR hiring platform that will allow clients to upload CVs, anonymize them using AI, match them to 
companies' open positions, and grant companies access to these anonymized CVs upon payment. The platform also needs to 
provide administrator access for monitoring, reporting, and management. To ensure scalability, cost-efficiency and 
maintainability.

Based on the requirements, we identified the need of the following components:

- Web Application
- RESTful Services to manage candidates, employers and resumes
- AI models to process resumes
- Workflow Engine to match candidates with jobs
- Database Engine to store the data
- File Storage to store resumes and job offers
- Authentication Provider
- Analytics/Reporting Service
- Monitoring Tools

So, we need to choose an infrastructure model, which can help us implement those components easily and cost effectively.

# Decision

We have chosen to adopt a Serverless Event-Driven Architecture on public cloud infrastructure to meet the platform's 
requirements.

We have chosen to use Amazon Web Services (AWS) as a cloud provider.

## Why Serverless and Event-Driven?

- **Scalability:** A serverless approach automatically scales with traffic, ensuring the platform can handle varying 
loads, from a few to thousands of users.
- **Cost Efficiency:** Pay-per-use pricing means we only incur costs based on the actual usage of the platform 
(storage, processing, API calls), reducing unnecessary operational overhead.
- **Event-Driven:** By utilizing event-driven triggers (e.g., CV uploads, payment verification), we can decouple 
components and ensure flexibility and responsiveness, as different workflows are executed only when required.

## Why AWS?

AWS is a leading cloud and serverless provider, offering a range of solutions for building scalable and efficient 
applications without managing infrastructure. With Serverless Compute services like AWS Lambda and Step Functions, 
developers can focus on writing code while AWS handles provisioning and scaling. For Serverless Storage, AWS provides 
numerous options, including **S3** for object storage, Amazon Aurora databases, and others, ensuring flexible, 
cost-efficient data management. Additionally, AWS empowers AI-driven applications with Bedrock, an AI service for 
building and scaling AI models easily. These features make AWS a comprehensive platform for modern cloud-based 
development.

## Alternatives Considered

On-premise cloud:

- A self-hosted application would require provisioning and maintaining servers, databases, and ML models, leading to 
higher operational overhead.

Managed Containers (ECS or EKS):

- Using ECS or EKS for containerized workloads would provide more control over the infrastructure, but it is more 
expensive. Given the expected scale and cost considerations, a fully serverless approach is more appropriate.

# Consequences

## Positive

- Simplified Operations: With managed services (Lambda, S3, Amazon Aurora, API Gateway), we avoid the need for 
provisioning and maintaining infrastructure.
- Elastic Scalability: The architecture scales with the demand, ensuring high availability and fault tolerance.
- Cost Optimization: Only paying for actual usage with serverless functions and storage reduces unnecessary 
infrastructure costs.
- Decoupled Components: Event-driven design allows flexibility in modifying or replacing individual components without 
affecting the entire system.
- Machine Learning Integration: Bedrock provides easy integration with many cloud services.

## Negative

- We will be vendor-locked.
- We may incur higher costs than we expect if we fail to estimate them correctly.
- We will either have little support or we will have to pay a lot for the enterprise-level support.

## Reversibility

This is a **one-way decision** which is very difficult to change afterwards. We will be able to partially move the 
workloads to other cloud providers or on-premise, but moving completely from AWS will be very costly.

 

