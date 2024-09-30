# Status

Approved

Zhivko Angelov, Viktor Isaev, Kiril Stoilov

# **Context**

Based on the requirements of the system, we need a storage for the following objects:

- Resumes (uploaded by candidates)
- Job offers (uploaded by employers)
- Invoices (generated by the system)

The proposed system should offer a cost-effective, secure and reliable solution for storing and retrieving those files.

# **Decision**

Since we decided to implement our system in a public cloud, we decided to leverage the native storage service of the 
respective cloud provider. For AWS, it is Amazon S3.

## Proposed storage

Amazon Simple Storage Service (Amazon S3) is an object storage service, which is easy to configure, manage and use. It 
offers efficient and secure storage and retrieval of files and objects.

## **Alternatives**

- Using other cloud storage service, e.g. Google Storage or Azure blob: Amazon S3 has similar (if not slightly better) 
characteristics in terms of availability, scalability, performance and cost. Main advantage of Google Storage is the 
more effective computing but this is not an important aspect in our system because we expect the files to be processed 
only once during the upload.
- Using a blob database or a blob field in a relational database: Databases are efficient when we have a need for 
indexing and frequent querying of a file content. However, in our case, the main requirement is to have a simple, 
scalable and robust storage, which is better covered by storage services, such as S3.

# **Consequences**

## Positive

- Simplicity: Leveraging the native storage service of the chosen cloud provider reduces unnecessary complexity.
- Performance: S3 is a highly-performance storage; in addition, we minimize the network time integrating services and 
storage from the same data center.
- Maintainability: S3 is a managed service that does not require additional effort for provisioning and maintenance.
- Elastic Scalability: The storage can easily scale with the demand.
- Cost Optimization: Only paying for actual usage reduces unnecessary infrastructure costs.
- Security: S3 offers industry-leading data protection and encryption.

## Negative

- Limited extensibility: In case we have a future need to search in or batch process the stored files, Amazon S3 is not 
a good option, and we have to consider a blob database.