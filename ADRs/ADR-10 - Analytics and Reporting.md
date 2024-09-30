# Status

Approved

Zhivko Angelov, Kiril Stoilov, Viktor Isaev

# Context

The platform involves processing user-uploaded resumes, anonymizing and matching through a set of AWS services, which 
include API Gateway, Microservices, Workflow Step Functions, Database, Object Storage, AI services and integration with 
external systems.

To provide value through business insights, analytics and reporting, we need to implement an **Analytics and Reporting 
system** that can track key performance metrics and user interactions within this platform. The key areas of interest 
include:

- Tracking user actions, such as the number of uploaded resumes and anonymization requests.
- Monitoring system performance, including processing resumes and the success/failure rates of anonymization and 
matching tasks.
- Generating reports on the anonymization and matching success, trends in uploaded resume types.

# **Decision**

### Use AWS native services for analytics and reporting

The Analytics and Reporting functionality will be implemented using **AWS CloudWatch**, **AWS Lambda**, **Amazon 
Athena**, and **Amazon QuickSight**. These services will provide end-to-end monitoring, logging, querying, and 
reporting capabilities for system and user activities.

**Components and Workflow**:

**CloudWatch Metrics and Logs** - CloudWatch will be used to collect metrics and logs from the API Gateway, AWS Step 
Functions, and Lambda functions.

**Data Storage in S3 for Analytics** - S3 will be used as the central storage for system logs.

**Amazon Athena for Ad-hoc Queries**

- **Amazon Athena** will be used to perform **SQL-like ad-hoc queries** on the data stored in S3 and RDS. This will 
allow the team to analyze trends.

**Amazon QuickSight for Visualization and Reporting**

- **Amazon QuickSight** will be used to create **visual dashboards** based on the Athena queries. This will provide 
administrators with real-time insights.
- Dashboards will be refreshed at regular intervals and made available to system administrators and relevant 
stakeholders.

**Historical Data Retention**

- Logs and metrics will be stored in S3 for long-term retention and analysis. The retention policy can be configured to 
retain data for 12 months, after which older data can be archived to **S3 Glacier** if needed.

**Reporting Frequency**

- **Daily**, **weekly**, and **monthly** reports will be generated using Athena queries and visualized in QuickSight to 
track KPIs, including the number of anonymization requests, resume matching, system errors, and user growth.

## Decision criteria

The decision to use **AWS CloudWatch**, **S3**, **Athena**, and **QuickSight** for analytics and reporting was based on 
several key factors:

1. **Scalability**: All AWS services are highly scalable and can handle the anticipated load as the system grows 
(increased number of resumes and anonymization requests).
2. **Cost-effectiveness**: By storing logs and metadata in S3 and querying them using Athena, costs are minimized.
3. **Real-time Monitoring**: CloudWatch provides real-time monitoring, alarms, and logging of system performance, 
allowing quick response to any operational issues.
4. **Ease of Integration**: AWS services like QuickSight integrate seamlessly with Athena, making it easy to generate 
and share dashboards with non-technical stakeholders.

## **Alternatives Considered**

- **ElasticSearch & Kibana**: We considered using an ElasticSearch-Kibana stack for real-time monitoring and querying. 
However, this approach was more complex to manage, and it brings scaling and cost concerns.
- **RDS for Analytics**: Using an RDS instance for storing logs and generating reports was considered. However, this 
approach would have introduced more complexity in managing the schema and higher costs for long-term data storage 
compared to using S3 and Athena.

# Consequences

**Positive**:

- The architecture ensures that the system has a reliable, scalable, and cost-effective way to track key performance 
metrics and generate reports.
- Real-time dashboards via QuickSight enable better decision-making and operational visibility.
- The use of Athena for ad-hoc queries enables flexibility in reporting without the need for complex ETL pipelines.

**Negative**:

- There is a potential for increased cost as the volume of data grows, especially when querying large datasets in 
Athena or storing large amounts of logs in S3. This will need careful monitoring.
- There is a learning curve for setting up and managing QuickSight for non-technical users.
