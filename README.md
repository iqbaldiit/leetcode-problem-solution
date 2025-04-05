# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)


| Service                     | Provisioned Type / Tier           | Monthly Base Cost (USD) | Reasoning                                                                 |
|----------------------------|-----------------------------------|--------------------------|---------------------------------------------------------------------------|
| AWS Lambda                 | Provisioned Concurrency = 1       | ~$3.20                   | $0.0000041667/sec per 1 concurrency x 730 hours (~1 month).               |
| Amazon API Gateway         | REST API (Regional Endpoint)      | ~$3.50                   | $3.50/month for regional endpoint + $1/million requests if any.           |
| Amazon DynamoDB            | Provisioned (1 RCU + 1 WCU)       | ~$1.50                   | ~$0.75 per RCU & WCU monthly; lowest provisioned config.                  |
| Amazon S3                  | Storage (5GB) + Requests          | ~$0.15                   | ~$0.03/GB/month; estimated low traffic and request count.                 |
| Amazon Aurora Serverless v2| Min Capacity (0.5 ACU)            | ~$9.65                   | Aurora v2 costs ~$0.06/hr (0.5 ACU x 730 hrs); paused = $0.               |
| AWS CloudWatch             | Logs + Metrics                    | ~$2.00                   | Includes basic logs and monitoring even with minimal usage.               |
| Amazon EventBridge         | 1 Rule + 0 events                 | ~$1.00                   | Each rule ~$1/month; triggered or not.                                    |
| Amazon AppSync             | Min Provisioned Units             | ~$4.00                   | Provisioned GraphQL resolvers; base price even if unused.                 |
| Amazon Timestream          | Base Storage Tier                 | ~$2.50                   | Even without writes, storage tier incurs a base charge.                   |
| Amazon Kinesis Data Stream | 1 Shard Provisioned               | ~$15.00                  | $0.015/hr/shard x 730 hours/month; no scaling.                            |
| AWS Fargate (ECS)          | 1 Task (0.25 vCPU + 0.5GB RAM)    | ~$7.00                   | Fargate min task = ~$0.01025/hr => 730 hrs/month = ~$7.49                 |
| AWS IAM / Secrets Manager  | 2 Secrets                         | ~$0.80                   | ~$0.40/month per secret stored.                                           |

| **Total Estimated Base**   |                                   | **~$50.80 – $55.00**     | All provisioned with minimal specs; always-on even with no user activity.|

