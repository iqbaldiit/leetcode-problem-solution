# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)

| Service                        | Cost Estimation (Monthly) | Reasoning                                                                          |
| ------------------------------ | ------------------------- | ---------------------------------------------------------------------------------- |
| AWS API Gateway                | $3–$5                     | Base cost is low; cost increases with API requests.                                |
| AWS Cognito                    | $0                        | Free for up to 50,000 monthly active users.                                        |
| AWS Fargate                    | $20–$50                   | Base cost for idle containerized services (Fargate keeps a few instances running). |
| AWS Lambda                     | $1–$3                     | Idle usage (only minimal invocations).                                             |
| AWS ElastiCache (Redis)        | $15–$30                   | Small Redis instance for maintaining minimal WebSocket connections.                |
| AWS IoT Core + Kinesis         | $10–$25                   | Minimal IoT devices connecting.                                                    |
| AWS DynamoDB                   | $5–$10                    | Base storage cost for metadata and logs.                                           |
| AWS S3                         | $1–$5                     | Basic cost for S3 buckets (static data & analytics).                               |
| AWS Timestream                 | $5–$10                    | Base cost for keeping recent telemetry data.                                       |
| Aurora PostgreSQL (Serverless) | $30–$50                   | Base cost for Aurora storage, minimal read/write load.                             |
| AWS CloudWatch                 | $5–$15                    | Base logging and performance monitoring.                                           |
