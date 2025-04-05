# Leetcode Problems with solution
## 1. Introduction to pandas
## 2. SQL 50 (MSSQL)

# Bicycle Racing Platform

## Biggest Challenges
This section lists our the biggest technical challenges and their solutions.

1.	Handling Concurrent user access in real time:   
    a.	Challenges:
        i.	As multiple races can be run simultaneously and infinite number of user both spectators and cyclists can be logged in, user concurrency is a biggest challenge and it should be 0 RTO.
        ii.	Risk of API throttling, slow response times, and race data inconsistencies.

    b.	Solutions:
        i.	Implement connection pooling and session management to optimize resource uses and rate limiting to prevent API abuse and backend performance. 
        ii.	Unique namespace for each race and partitioning based on particular races. 
        iii.	Use microservice architecture to isolate the service.

2.	Real time tracking and latency
    a.	Challenges:
        i.	While racing, track racer (GPS, lap time) data needs to be processed and updated in <1 second. If there is any delay, user experience will suffer.
        ii.	Consider minimum battery drain on mobile devices because, the race might be run for long time and device battery time is very important.
    
    b.	 Solutions:
        i.	Use Device GPS to track racer positions and push data to the server. High throughput messaging ques to manage event process efficiently. Like AWS Kinesis data stream.
        ii.	Use persistent connections and data synchronization using even driven communication for instant data updates like AWS AppSync.
        iii.	Use SQLite database for temporary racing data so that if connectivity lost, data can be synced while connected.
        iv.	Compress the data before transmit so that low connectivity can’t affect the transmission.

3.	High availability and fault tolerance 
    a.	Challenges:
        i.	The system should stay operational even if some components fail.
        ii.	Avoid single point of failure in the architecture.

    b.	Solutions:
        i.	Design multi region deployments to ensure uptime and 0 RTO.
        ii.	Implement automatic failover mechanisms. 

4.	 Security and Authentication
    a.	Challenges:
        i.	As lot of users will access concurrently, security and authentication is big challenges.
    
    b.	Solution:
        i.	Use token-based authentication.
        ii.	User Role based authorization like admin user, racer as user, spectator as user as the system requires. 
        iii. Data can be encrypted at rest and in transit.
  
    

*[TODO: Please use this section to identify the biggest challenges that you see and solutions that you would implement for them]*

## Technical Decisions

### High Level Architecture Design
The diagram belows shows the high level component diagram that could be used to fulfil the requirements.

*[TODO: Please draw a high level architecture diagram and explain each component below]*

![image](https://github.com/user-attachments/assets/513b2279-6158-4ef5-b4d1-7f986c15248e)


![High Level Architecture Diagram](/assets/diagram-placeholder.png)

On the basis of application context, technology familiarity of the organization, Scalability, High availability, performance and business continuity, hybrid model using AWS Serverless and microservice architecture is well suited.
1.	AWS Serverless: cost efficiency, scalability and simplicity. Well suited for backend APIs including all administrative functions, user management, race configuration and so on.
2.	Containerized Microservice is for real-time processing and high performance. Avoid connection managements challenges of pure serverless.

Architecture overview
1.	Client Applications
    a.	Mobile App Tracker uses MQTT (Message Queuing Telemetry Transport) via AWS IoT real time telemetry.
    b.	Web & Mobile App for general user integrate via API Gateway (REST) and AppSync for live updates.

2.	Authentication: AWS Cognito manages authentication with security of API and web socket access.

3.	Real time data processing: 
    a.	AWS IoT Core + Kinesis computes live telemetry.
    b.	Lambda Aggregation processes events before storage.
    c.	Timestream efficiently handle data for analytics

4.	Microservices (AWS Fargate)
    a.	Auto-scaled WebSocket (Node.js) service for real-time communication.
    b.	Redis (ElastiCache) for low-latency real-time data retrieval.

5.	Backend Service (AWS Lambda)
    a.	Handles User, Race, and Admin Management with minimal overhead.
    b.	AWS S3 for static data and DynamoDB for operational data.

6.	Data Layer
    a.	DynamoDb for user profile, race configuration and other operation.
    b.	For historical, statistical or analytics ready data we need transformation. So we load data to AWS S3 Data Lake from timestream db through ETL Glue  and send it to the Aurora Database.
    c.	Dynamodb transform and load the data to Aurora through lambda.


### Technology Stack
1.	Web App (Admin and general user): React.js

2.	Mobile App: React Native, SQLite db -> Support both Android and IOS.

3.	Authentication & Authorization: AWS Cognito -> Support OAuth, OpenID and federated login.

4.	Backend Service: 
    a.	AWS Lambda (Node.js)-> Serverless backend services for managing races, participants, and users.
    b.	Express.js -> Handle API request and business logic.

5.	API Management
    a.	AWS API Gateway-> Manages API requests and route them to backend services (Lambda, Fargate)
    b.	AWS AppSync-> Provides real-time updates via GraphQL API, optimized for WebSockets.

6.	Real time data processing:
    a.	AWS Iot Core-> Collect  real time location data from mobile trackers via MQTT.
    b.	AWS Kinesis Data Streams -> Handles high-velocity telemetry data and ensures scalability.
    c.	AWS Lambda -> Aggregates and processes incoming IoT data.

7.	Microservice for race tracking:
    a.	AWS Fargate (ECS)-> Runs containerized services without managing servers.
    b.	Node.js + WebSocket-> Handles live event updates for the race dashboard.
    c.	AWS ElastiCache (Redis) -> Caches race data for low-latency performance.
    d.	Fargate Auto-scaling -> Ensures dynamic scalability during high traffic.  

8.	Data Layer (Storage & Analytics):
    a.	AWS Timestream -> Store telemetry and event tracking data efficiently.
    b.	AWS DynamoDB-> key value storage for user profile, administration and race related data.
    c.	AWS S3 Data Lake -> Stores aggregated race history and statistical data.
    d.	Amazon Aurora (PostgreSQL) -> Stores structured analytics data and supports SQL-based queries.
    e.	AWS Glue -> for ETL data pipeline.

9.	Deployment & DevOps:
    a.	AWS ECS (Fargate)-> for container orchestration. Manages containerized workloads without managing servers.
    b.	AWS CDK -> Infrastructure as Code (IaC). For automating AWS infrastructure provisioning
    c.	AWS CloudWatch-> Tracks system performance, logs API requests, and traces transactions.
    d.	AWS CodePipeline / Github action -> for Automating application deployment.

10.	Security & Compliance:
    a.	AWS IAM-> Manages permissions and security policies.
    b.	AWS KMS -> Encrypt sensitive race data at rest and in transit.
    c.	AWS WAF -> Protects against unauthorized access and attacks.

*[TODO: Explain the technology stack to be used here]*

## Runtime Cost Analysis
*[Todo: Do the runtime cost analysis in this section]
The following is the base cost (No User). In serverless mode there is no base cost nearly 0 or 2 to 12 USD /month (because of some "alawys on"  Service).
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
| AWS IAM                | $0.00                    | No cost for creating users, roles, policies.                               |
| AWS KMS                | ~$1.00                   | $1/month per key, even if not used. Used for encrypting data at rest.      |
| AWS CodePipeline       | ~$1.00                   | $1/month per active pipeline. First pipeline is free.                      |
| AWS CDK                | $0.00                    | Free CLI/SDK tool. No runtime cost.                                        |
| AWS WAF                | ~$5.00                   | $5/month per Web ACL + ~$1/rule/month (estimate based on 3 rules = $3).    |
| AWS CloudWatch         | ~$2.00                   | Base monitoring + minimal logs (e.g., metrics retention and alerts).       |


### Cost Breakdown When Scaling Up (Monthly)

Scenario: A race event with 50,000 concurrent viewers and 50 riders. This triggers higher compute, streaming, and data handling demand.

### Core Services (Application Specific)

| Service                     | Scale-Up Unit                         | Monthly Scale-Up Cost |
|-----------------------------|----------------------------------------|------------------------|
| AWS API Gateway             | +5 million requests                    | **$17.50**             |
| AWS Lambda                  | +10 million requests                   | **$2.00**              |
| AWS AppSync                 | +2 million GraphQL operations          | **$32.00**             |
| AWS Fargate                 | +5 running tasks (720 hrs/task)        | **$146.40**            |
| AWS Kinesis Data Streams    | +2 shards                              | **$21.60**             |
| Amazon Aurora Serverless v2 | +2 ACUs for 20 hrs/day                 | **$41.60** *(est.)*    |
| Amazon DynamoDB             | +1 million read/write units            | **$3.00** *(est.)*     |
| AWS Timestream              | +5 million writes/queries              | **$2.50** *(est.)*     |
| AWS S3                      | +50 GB data stored/transferred         | **$1.25**              |

---

### Infrastructure & Supporting Services

| Service                     | Scale-Up Unit                         | Monthly Scale-Up Cost |
|-----------------------------|----------------------------------------|------------------------|
| Amazon CloudWatch Logs      | Increased logging traffic              | **$5.00** *(est.)*     |
| AWS WAF                     | +1M requests, 1 rule group             | **$1.00**              |
| AWS IAM                     | Usage-based                            | **$0.00**              |
| AWS KMS                     | +100K key requests                     | **$1.00** *(est.)*     |


---
### **Total Estimated Additional Monthly Cost**: **~$273.85**

##### Pricing source and reference: internet / aws price calculator




--------------------------------------
![Scopic Software](/assets/footer.png)
