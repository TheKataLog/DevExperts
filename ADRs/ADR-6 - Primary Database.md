# **Status**

Approved

Viktor Isaev, Zhivko Angelov, Denis Iudovich, Kiril Stoilov

# **Context**

We need databases, to store

- users’ data (employees, employers, internal users of system (admins))
- information about companies
- resumes of employees
- hints from LLM
- hiring decisions
- analytics

# **Decision**

Implementation of a relational database, and more specifically - SQL database based on serverless Amazon Aurora.

## **SQL vs. Document-oriented**

A solution to use a document-oriented database to store resumes such as MongoDB looks good because offers us an 
opportunity to work with documents in a specially designed environment, without worrying about new document formats and 
fields.

On the other hand, we have SQL, such as PostgreSQL, which offers data consistency and integrity, reliable replication, 
easy scaling and many ready-made integration capabilities. Moreover, if we will look at secondary tasks - it becomes 
clear that the database is more suitable for storing entities such as users, companies, surveys and their results 
mapped on users.

So, we see this picture:

### Comparison
| Document-Oriented | SQL |
| --- | --- |
| Comfortable programming | Data integrity |
| Less joins | Scalability |
| Flexible schema | Extensibility |
| Simple migration for huge datasets | One DBMS for any tasks |


## Serverless PostgreSQL

We want to use serverless solution to reduce costs. We use AWS to deploy our environment, so we want to consider Amazon 
Aurora.

But let’s compare it to Neon for example to make sure we chose the best option.

While performance is not so critical in this system, let's compare costs:

### Cost Comparison
| Feature | Neon | Amazon Aurora |
| --- | --- | --- |
| 4xCU, 10GB storage  300 hours | 19$ | 72 + 1(10GB)+1(5kk requests) = 74$ |
| 8xCU,50GB 750 hours  | 69$ | 178,56+5(50GB) +1(5kk requests) = 184,56$ |
| 8xCU,500GB, 1000 hours | 700$ | 357,12 + 50(500GB) +1(5kk requests) = 408,12$ |
| 2xCU, 50GB storage 300 hours *(close to our case)* | 69$ | 36$ + 5(50GB) + 1(5kk requests) = 42$ |
| 0,5xCU, 50GB storage 300 hours (Aurora ver. 2 required) | 69$ | 18$ + 5(50GB) + 1(5kk requests) = 24$ |


As we can see, Neon can be cheaper in some cases, but Amazon Aurora is more flexible. So, in our case, where we 
probably wouldn’t need much performance, but need significant amount of space it should be not only more comfortable to 
use Amazon Aurora, but cheaper as well.

# **Consequences**

## Positive

- Data integrity - chosen system doesn’t have problems with data loss even in exotic scenarios because of huge 
community and years of development
- Scalability - chosen system has ready-made replication and orchestration solutions
- Extensibility - chosen system provides us a lot of ready-made integrations with third-party systems
- Low costs

## Negative

- Designing SQL database is harder than document-oriented
- Changes applying is harder because schema is not flexible
- In case of unexpected loads, costs could increase even higher than another service providers

## Reversibility

The SQL part is a **one-way decision** which is difficult to change once applied. The implementation part (Amazon 
Aurora) is **somewhat reversible**, meaning that we can change the underlying engine with some operational effort given 
that it is still SQL.

