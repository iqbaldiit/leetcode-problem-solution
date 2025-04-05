# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)



| Service                     | Mode              | Monthly Base Cost (USD) | Reasoning                                                                 |
|----------------------------|-------------------|--------------------------|---------------------------------------------------------------------------|
| **Core Services**          |                   |                          |                                                                           |
| AWS Lambda                 | Serverless        | $0.00                    | Pay-per-invocation. No usage = $0.                                        |
| Amazon API Gateway         | Serverless        | ~$0.00 – $3.50           | $3.50 base fee for regional endpoints if provisioned.                     |
| Amazon DynamoDB            | On-Demand         | $0.00                    | Pay-per-read/write.                                                       |
| Amazon S3                  | Serverless        | ~$0.15                   | Minimal storage assumed (e.g. logs, configs).                             |
| Amazon Aurora Serverless v2| Serverless        | $0.00 (paused)           | Can scale to 0 ACU when not in use.                                       |
| AWS CloudWatch             | Always On         | ~$2.00                   | Retains and stores logs.                                                  |
| AWS Fargate                | Serverless        | $0.00                    | Pay-per-task. No task = $0.                                               |
| Amazon Timestream          | Serverless        | ~$2.50                   | Minimal storage charges.                                                  |
| AWS AppSync                | Serverless        | $0.00                    | No query = no charge.                                                     |
| Amazon Kinesis             | Serverless        | $0.00                    | No data stream = $0.                                                      |

| **Infrastructure Services** |                   |                          |                                                                           |
| AWS IAM                    | Always On         | $0.00                    | No charge for roles/users/policies.                                      |
| AWS KMS                    | Serverless        | ~$1.00                   | $1/month per KMS key + usage costs.                                      |
| AWS CodePipeline           | Serverless        | $1.00 per active pipeline| First pipeline free, then $1/pipeline/month.                             |
| AWS CDK                    | N/A               | $0.00                    | CDK is a CLI/SDK tool. No charge to use.                                 |
| AWS WAF                    | Always On         | ~$5.00 base + rule cost  | ~$5/month per ACL + $1 per rule/month.                                   |

| **Total Monthly Cost (No Usage)** | **Serverless Setup** | **~$12 – $20**           | Includes infra-level essentials (WAF, KMS, CloudWatch, etc).             |
|                                   | **Provisioned Setup** | **~$60 – $75**           | Includes minimum provisioned infrastructure with idle base pricing.      |
