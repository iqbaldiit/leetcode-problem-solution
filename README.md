# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)

The following is the base cost (No User). In serverless mode there is no base cost nearly 0 or 2 to 12 USD /month (because of some "alawys on"  Service)
all pricing source: internet / aws price calculator 

### Core Service Cost

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

### Infrastructure Service Cost

| Infrastructure Service | Monthly Base Cost (USD) | Description                                                                 |
|------------------------|--------------------------|-----------------------------------------------------------------------------|
| **AWS IAM**            | $0.00                    | No cost for creating users, roles, policies.                               |
| **AWS KMS**            | ~$1.00                   | $1/month per key, even if not used. Used for encrypting data at rest.      |
| **AWS CodePipeline**   | ~$1.00                   | $1/month per active pipeline. First pipeline is free.                      |
| **AWS CDK**            | $0.00                    | Free CLI/SDK tool. No runtime cost.                                        |
| **AWS WAF**            | ~$5.00                   | $5/month per Web ACL + ~$1/rule/month (estimate based on 3 rules = $3).    |
| **AWS CloudWatch**     | ~$2.00                   | Base monitoring + minimal logs (e.g., metrics retention and alerts).       |


### Cost Breakdown When Scaling Up (Monthly)

Scenario: A race event with 50,000 concurrent viewers and 50 riders. This triggers higher compute, streaming, and data handling demand.
---

### 🔧 Core Services (Application Specific)

| Service                     | Scale-Up Unit                         | Monthly Scale-Up Cost |
|-----------------------------|----------------------------------------|------------------------|
| **AWS API Gateway**         | +5 million requests                    | **$17.50**             |
| **AWS Lambda**              | +10 million requests                   | **$2.00**              |
| **AWS AppSync**             | +2 million GraphQL operations          | **$32.00**             |
| **AWS Fargate**             | +5 running tasks (720 hrs/task)        | **$146.40**            |
| **AWS Kinesis Data Streams**| +2 shards                              | **$21.60**             |
| **Amazon Aurora Serverless v2** | +2 ACUs for 20 hrs/day             | **$41.60** *(est.)*    |
| **Amazon DynamoDB**         | +1 million read/write units            | **$3.00** *(est.)*     |
| **AWS Timestream**          | +5 million writes/queries              | **$2.50** *(est.)*     |

---

### Infrastructure & Supporting Services

| Service                     | Scale-Up Unit                         | Monthly Scale-Up Cost |
|-----------------------------|----------------------------------------|------------------------|
| **Amazon CloudWatch Logs**  | Increased logging traffic              | **$5.00** *(est.)*     |
| **AWS S3**                  | +50 GB data stored/transferred         | **$1.25**              |
| **AWS WAF**                 | +1M requests, 1 rule group             | **$1.00**              |
| **AWS IAM**                 | Usage-based                            | **$0.00**              |
| **AWS KMS**                 | +100K key requests                     | **$1.00** *(est.)*     |


---

### **Total Estimated Additional Monthly Cost**: **~$273.85**




