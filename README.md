# terraform

## overview
- ninja
- list
* jhuj

* jo0udsihds /
hdbkd ishuh
* jioysujk

* nkc xh


- [Overview](#overview)
- [Features](#features)


| Left Align     | Center Align   | Right Align    |
|:---------------|:--------------:|---------------:|
| Row 1, Cell 1  | Row 1, Cell 2  | Row 1, Cell 3  |
| Row 2, Cell 1  | Row 2, Cell 2  | Row 2, Cell 3  |
| Row 3, Cell 1  | Row 3, Cell 2  | Row 3, Cell 3  |


# Assignement 04 

- [Objective](#Objective:) 

The goal of this assignment is to design and implement infrastructure of your individual tool using Terraform IaC (Infrastructure as Code) based on your architecture diagram. You will follow best practices, manage the Terraform state file in S3, and ensure consistent provider versioning throughout your code. 
Steps: 

Create an Infrastructure Architecture Diagram: 

-  Design an architecture diagram that outlines the infrastructure components you plan to create. This should include networking, servers, load balancers, auto-scaling groups, and any other necessary components. 
-  Submit the architecture diagram for review and approval before moving to the implementation phase. 

Implement the Infrastructure with Terraform: 

-    Based on the approved architecture diagram, write Terraform code to provision the infrastructure. 
-    Write static Terraform code to implement the infrastructure as per the reviewed architecture diagram.

Good To Do: 
Terraform State Management- 
Terraform State Management: Store the Terraform state file (tfstate) in an S3 bucket to enable remote state management. 

### Infrastructure Architecture Diagram
![alt text](Infra.png)

### Implement the Infrastructure with Terraform:
###### Networking
* VPC
![alt text](VPC.png)

###### Security
* nacl
![alt text](Nacl.png)

* security group
![alt text](<Security Groups.png>)

###### Compute
* Instance
![alt text](Instance.png)

* Target group
![alt text](Targetgroup.png)

* Load Balancer
![alt text](<Load Balancer.png>)

### Good To Do: 
##### Terraform State Management- 
* S3 bucket to enable remote state
![alt text](Backend.png)

* DynamoDB
![alt text](DynamoDB.png)
