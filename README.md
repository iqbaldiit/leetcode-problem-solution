# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)

| Service                     | Mode              | Monthly Base Cost (USD) | Reasoning                                                                 |
|----------------------------|-------------------|--------------------------|---------------------------------------------------------------------------|
| AWS Lambda                 | Serverless        | $0.00                    | Charges only for invocations + execution time. No usage = no cost.        |
|                            | Provisioned (1 concurrency) | ~$3.20           | Minimum concurrency reserved → billed hourly even if not invoked.        |
| Amazon API Gateway         | Serverless        | ~$0.00                   | Charges per request. No traffic = no cost.                                |
|                            | Provisioned (Regional Endpoint) | ~$3.50        | $3.50/month base fee for endpoint maintenance, even with no usage.       |
| Amazon DynamoDB            | On-Demand         | $0.00                    | Charges per read/write. No activity = no cost.                            |
|                            | Provisioned (1 RCU + 1 WCU) | ~$1.50            | Minimum provisioned capacity is always billed.                           |
| Amazon S3                  | Serverless        | ~$0.15                   | Charges for storage + requests. 5GB data assumed as minimum.              |
|                            | Provisioned (N/A) | N/A                      | S3 is inherently serverless.                                              |
| Amazon Aurora (PostgreSQL) | Serverless v2     | $0.00 (paused state)     | Aurora Serverless v2 can pause at 0 ACU. Paused = no cost.               |
|                            | Provisioned (0.5 ACU) | ~$9.65               | Even 0.5 ACU incurs cost at ~$0.06/hr.                                    |
| AWS CloudWatch             | Always On         | ~$2.00                   | Logs and metrics collected even without user activity.                    |
| Amazon EventBridge         | Serverless        | ~$0.00                   | Charged per invocation. No events = no cost.                              |
|                            | Provisioned (1 Rule) | ~$1.00               | Rule fee applies even without events.                                     |
| AWS AppSync                | Serverless        | $0.00                    | Charged per query. No usage = no cost.                                    |
|                            | Provisioned       | ~$4.00                   | Base fee for minimum resolvers.                                           |
| Amazon Timestream          | Serverless        | ~$2.50                   | Charged for storage tier even with no writes.                             |
| Amazon Kinesis             | Serverless        | $0.00                    | No ingestion = no cost.                                                   |
|                            | Provisioned (1 shard) | ~$15.00             | $0.015/hr = ~$10-15/month minimum.                                        |
| AWS Fargate (ECS Tasks)    | Serverless        | $0.00                    | No running tasks = no charges.                                            |
|                            | Provisioned Task (0.25 vCPU + 0.5 GB RAM) | ~$7.00   | Minimum running container billed hourly.                                 |
| AWS Secrets Manager        | Always On         | ~$0.80                   | Charged per secret stored per month.                                      |

| **Total Monthly Cost (No Usage)** | **Serverless Setup** | **~$5.45 – $10.00**     | Pay-per-use model; no usage = nearly zero cost.                         |
|                                   | **Provisioned Setup** | **~$50.00 – $60.00**    | Always-available resources incur minimum charges even without traffic.  |

