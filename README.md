# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)

Base Cost (No User). In serverless mode there is no base cost nearly 0 or 2 to 12 USD /month (because of some infrua)

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


| Infrastructure Service | Monthly Base Cost (USD) | Description                                                                 |
|------------------------|--------------------------|-----------------------------------------------------------------------------|
| **AWS IAM**            | $0.00                    | No cost for creating users, roles, policies.                               |
| **AWS KMS**            | ~$1.00                   | $1/month per key, even if not used. Used for encrypting data at rest.      |
| **AWS CodePipeline**   | ~$1.00                   | $1/month per active pipeline. First pipeline is free.                      |
| **AWS CDK**            | $0.00                    | Free CLI/SDK tool. No runtime cost.                                        |
| **AWS WAF**            | ~$5.00                   | $5/month per Web ACL + ~$1/rule/month (estimate based on 3 rules = $3).    |
| **AWS CloudWatch**     | ~$2.00                   | Base monitoring + minimal logs (e.g., metrics retention and alerts).       |


## 📈 Cost Breakdown When Scaling Up

| Scalable Service        | Pricing Model                             | Estimated Additional Cost (Per Unit Scale Up)                  | Notes                                                                 |
|-------------------------|-------------------------------------------|----------------------------------------------------------------|-----------------------------------------------------------------------|
| **API Gateway**         | $3.50 per million requests                | +$3.50 per million requests                                     | Cost increases with user requests hitting REST endpoints.             |
| **Lambda**              | $0.20 per million invocations + GB-s     | +$0.20 per million invocations                                 | Add cost based on execution time and memory use.                      |
| **S3 (Storage)**        | $0.023/GB for Standard                   | +$0.023 per GB stored                                           | For file uploads, reports, backups, etc.                              |
| **DynamoDB**            | Pay-per-request or provisioned           | +$1.25 per WCU/RCU units (optional auto-scaling)               | Write and read capacity increases with user-generated data.           |
| **Aurora Serverless**   | $0.06 per ACU-hour                       | +$0.06 per ACU-hour                                            | Scales with connections/queries.                                      |
| **AWS Kinesis**         | $0.015 per shard-hour                    | +$0.015 per active shard-hour                                  | Scales with real-time event ingestion (cycling data, etc.).           |
| **Fargate**             | $0.04048/vCPU/hr + $0.004445/GB/hr       | Depends on task size and runtime duration                      | Used if you move parts of app into containers (e.g., image processing).|
| **CloudWatch Logs**     | $0.50 per GB ingested                    | +$0.50 per GB of logs                                          | More users = more logs, metrics, alerts.                              |
| **SQS / SNS**           | $0.40 per million requests/messages      | +$0.40 per million messages                                    | Useful for internal async communication at scale.                     |
| **AWS Timestream**      | Ingest: $0.50/MB, Store: $0.03/GB-month  | Ingest + storage + queries                                     | For time-series sensor data from real-time trackers.                  |

### 🔁 Scaling Summary

- Every **1 million requests** (via API Gateway + Lambda) ≈ **$3.70–$4.00**
- Every **1 GB of additional storage** ≈ **$0.02–$0.03**
- Adding real-time data processing (e.g., Kinesis or Fargate) introduces variable compute/storage pricing.
- Logs, notifications, and stream data scale **linearly** with user and event growth.

### ⚠️ Notes

- Services like **Lambda**, **API Gateway**, and **DynamoDB On-Demand** scale seamlessly, but costs accumulate based on throughput.
- Proper **monitoring** and **auto-scaling configuration** is essential to prevent runaway costs.


