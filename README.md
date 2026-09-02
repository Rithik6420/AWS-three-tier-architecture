# AWS Three-Tier Architecture Project

## Project Overview

This project demonstrates the implementation of a highly available three-tier architecture on AWS.

The architecture separates the application into networking, application, and database layers using public and private subnets across multiple Availability Zones.

User traffic is received by an internet-facing Application Load Balancer and distributed between two EC2 application servers running in private subnets. The application servers communicate with an Amazon RDS MySQL database deployed in the database tier.

---

## Architecture

Internet User
↓
Internet Gateway
↓
Application Load Balancer
↓
Target Group
↓
EC2 App Server 1 | EC2 App Server 2
↓
Amazon RDS MySQL

The VPC contains six subnets across two Availability Zones:

- 2 Public Subnets
- 2 Private Application Subnets
- 2 Private Database Subnets

---

## AWS Services Used

- Amazon VPC
- Amazon EC2
- Application Load Balancer (ALB)
- Target Groups
- Amazon RDS MySQL
- NAT Gateway
- Internet Gateway
- Route Tables
- Security Groups
- AWS Systems Manager Session Manager
- IAM

---

## Network Design

**VPC CIDR**

`10.0.0.0/16`

**Public Tier**

- Public Subnet 1 — `10.0.1.0/24`
- Public Subnet 2 — `10.0.2.0/24`

The public route table routes internet traffic through the Internet Gateway.

**Application Tier**

- App Subnet 1 — `10.0.3.0/24`
- App Subnet 2 — `10.0.4.0/24`

Two EC2 instances run Apache web servers in private application subnets.

The private application route table uses a NAT Gateway for outbound internet connectivity.

**Database Tier**

- DB Subnet 1 — `10.0.5.0/24`
- DB Subnet 2 — `10.0.6.0/24`

Amazon RDS MySQL is deployed in the database tier and is not directly accessible from the internet.

---

## Traffic Flow

User → Internet Gateway → Application Load Balancer → Target Group → EC2 Application Servers → RDS MySQL

The Application Load Balancer distributes incoming HTTP requests between the two healthy EC2 application servers.

---

## Security

Security Groups were configured to restrict communication between different tiers.

- ALB accepts HTTP traffic from the internet.
- Application EC2 instances accept HTTP traffic from the ALB Security Group.
- RDS accepts MySQL traffic on port `3306` from the application server Security Group.
- EC2 instances are deployed without public IPv4 addresses.
- AWS Systems Manager Session Manager is used to manage the private EC2 instances.

---

## High Availability

The architecture uses multiple Availability Zones.

Two application servers are deployed across:

- `ap-south-1a`
- `ap-south-1b`

The Application Load Balancer distributes requests across both healthy targets.

---

## Testing

Both application servers were successfully registered with the Target Group and passed ALB health checks.

Refreshing the Application Load Balancer endpoint demonstrated traffic distribution between:

**App Server 1**

and

**App Server 2**

---

## Troubleshooting Experience

During implementation, I identified and resolved several configuration issues:

- Private application subnets were initially not associated with the correct private route table.
- SSM Agent could not communicate with AWS Systems Manager because the private EC2 instances did not initially have the correct NAT route.
- Apache installation through EC2 User Data failed due to unavailable outbound connectivity.
- RDS connectivity was resolved by configuring the correct Security Group relationship between the application and database tiers.
- Application Load Balancer, Target Group, listener, health checks, and Security Groups were validated to successfully expose the application.

These troubleshooting steps provided practical experience with AWS networking, routing, security, and application connectivity.

---

## Project Screenshots

Implementation screenshots are available in the [`screenshots`](./screenshots) directory.

They include:

- VPC configuration
- Public and private subnets
- Route tables
- NAT Gateway
- EC2 application servers
- Application Load Balancer
- Target Group health checks
- Amazon RDS MySQL
- Final application output from both servers

---

## Key Skills Demonstrated

- AWS VPC Design
- Public and Private Subnet Architecture
- Multi-AZ Deployment
- EC2 Administration
- Application Load Balancing
- Linux / Apache Administration
- AWS Systems Manager
- IAM Roles
- Security Groups
- NAT Gateway
- Amazon RDS MySQL
- AWS Network Troubleshooting

---

## Result

Successfully deployed and tested a three-tier AWS architecture with load-balanced EC2 application servers and a private Amazon RDS MySQL database.
