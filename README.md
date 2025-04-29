# summary

![](https://docs.bmc.com/xwiki/bin/download/Service-Management/IT-Service-Management/BMC-Helix-ITSM-Service-Desk/servicedesk251/Getting-started/Key-concepts/Incident-Management-overview/WebHome/Apps_Relationships.png?height=400&rev=1.1)
 
  
  Here's an overview of these components:

![](https://docs.bmc.com/xwiki/bin/download/Service-Management/IT-Service-Management/BMC-Helix-ITSM-Service-Desk/servicedesk251/Getting-started/Key-concepts/Incident-Management-overview/WebHome/Incident%20Management%20Process.png?rev=1.1)

---

🔧 Incident Management

    


---

🧩 Problem Management

Aims to identify and eliminate the root causes of incidents to prevent recurrence. This process includes conducting root cause analyses and coordinating with Change Management to implement solutions. 


---

🔄 Change Management

Manages the lifecycle of all changes to minimize disruption to IT services. It encompasses stages such as initiation, assessment, planning, implementation, and closure, ensuring that changes are systematically and efficiently handled. 


---

📚 Knowledge Management

    


---

🤖 BMC Helix ITSM Insights

    


---

  If you would like more detailed information on any of these areas or guidance on implementing them, feel free to ask!



## ITSM process types : 
Here’s a real-life example using a bank's mobile app to explain each ITSM concept:


---

1. Incident Management

Issue: Users can't log in to the app.
Action: IT logs the incident, prioritizes it as P0, and works to restore service quickly.
Goal: Get the login feature working again ASAP.


---

2. Problem Management

Finding: This is the 3rd login outage this month.
Action: A problem record is created. Root cause: overloaded authentication server.
Goal: Prevent future outages by fixing the root cause.


---

3. Change Management

Change: Dev team proposes replacing the old auth server.
Action: Change is reviewed, tested, scheduled, and deployed with minimal downtime.
Goal: Implement improvements without disrupting service.


---

4. Knowledge Management

Issue: Many users ask how to reset passwords.
Action: A “How to reset password” article is published on the help portal.
Goal: Help users self-solve simple issues, reduce support load.


---

5. Helix ITSM Insights (AI)

Scenario: AI notices spikes in failed login attempts every Monday.
Action: Recommends scaling the login service every Sunday night.
Goal: Proactively avoid Monday outages using data patterns.


---

You're right! Here's a continuation with Asset Management and Service Desk, using the same bank mobile app example:


---

6. Asset Management

What it is: Tracks all IT assets—hardware, software, licenses, etc.
Example:

The login server (where the incident occurred) is tracked in the CMDB (Configuration Management Database).

IT knows its owner, specs, warranty, and current health.
Goal: Know what assets exist, how they're used, and manage them efficiently.



---

7. Service Desk

What it is: The single point of contact between users and IT.
Example:

A customer calls saying “I can't log in.”

The service desk logs the ticket, gives updates, and escalates it to the right team.
Goal: Provide fast, friendly, and efficient support to users.



---

Let me know if you want a simple diagram or a cheat sheet for all of these.

Here’s a clear explanation of the main ITSM items (like in BMC Helix) and how they flow together in real-world scenarios:


---

1. Incident

Definition:
An unplanned interruption or reduction in the quality of an IT service.

Example:
A user can't access their email.

Goal:
Restore service as quickly as possible.


---

2. Service Request

Definition:
A formal request from a user for something standard (info, access, hardware, software).

Example:
A new employee requests a laptop or access to an application.

Goal:
Fulfill request as per SLA.


---

3. Work Order

Definition:
A task generated to complete part of a Service Request.

Example:
IT technician assigned to deliver and configure the requested laptop.

Goal:
Support the service request through action.


---

4. Change Request

Definition:
A formal proposal for modifying any part of the IT environment.

Example:
Request to upgrade database version in production.

Goal:
Make controlled changes with minimal risk.


---

5. Problem

Definition:
The underlying cause of one or more incidents.

Example:
Frequent email outages traced to a faulty mail server config.

Goal:
Identify root cause and prevent future incidents.


---

6. Known Error

Definition:
A problem that is diagnosed and has a workaround or a root cause identified.

Example:
Known bug in email server version; workaround documented.

Goal:
Speed up incident resolution by reusing solutions.


---

7. Task / Activity

Definition:
Sub-parts of incidents, changes, or problems assigned to specific teams or individuals.

Example:
One task in a change request may be to stop the service; another to update the software.


---

End-to-End Flow with Real Example

Scenario: Email service is down for multiple users

1. Incident is created

User reports "Can't access email."

IT logs an Incident.



2. Incident is escalated

Support checks and sees many users are affected.

It's a Major Incident.



3. Problem record is created

Repeated issue with email server.

A Problem is opened to investigate root cause.



4. Known Error is identified

Vendor confirms bug in current version.

A Known Error entry is created with a workaround.



5. Change Request is raised

Plan to upgrade the email server.

A Change Request is submitted and approved.



6. Tasks are assigned under Change

Tasks: Stop service, backup, install patch, test, restart service.



7. Change is implemented successfully

Email works again. Incident is closed.



8. Problem is closed

Root cause fixed. No more incidents expected.





---

Parallel Service Request Example

A user raises a Service Request for a new email account.

A Work Order is created to configure and assign the mailbox.



---

