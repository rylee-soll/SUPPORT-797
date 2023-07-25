## WorkflowEngine.NET

---

This is a sample solution on how to work with `IWorkflowActionProvider`.

To get started, follow these steps:

1. Clone the [repository](https://github.com/Andrew-Solo/SUPPORT-797).
2. Configure ConnectionStrings.DefaultConnection in [WF.Sample/appsettings.json](https://github.com/Andrew-Solo/SUPPORT-797/blob/main/WF.Sample/appsettings.json) to connect to your MS SQL Server.
3. Execute the following [scripts](https://github.com/Andrew-Solo/SUPPORT-797/tree/main/DB) one by one:
   - DB/CreatePersistenceObjects.sql
   - DB/CreateObjects.sql
   - DB/FillData.sql
4. Now, you can build and run the solution.

This example is based on an [existing sample](https://workflowengine.io/documentation/demo-description). You can see all the modifications made to the original code in the [pull request](https://github.com/Andrew-Solo/SUPPORT-797/pull/1).

Essentially, this solution enables you to manage instances of processes within a single workflow scheme. To view and edit the scheme, simply click the "Designer" button in the top panel. To create a new instance, just click on "Create vacation request."

There are added the implementation of `IWorkflowActionProvider` in the form of an [ActionProvider](https://github.com/Andrew-Solo/SUPPORT-797/blob/main/WF.Sample.Business/Workflow/ActionProvider.cs). This provider contains methods to manage data in the "Payments" table. When you explore the workflow, you'll notice that specific activities are associated with this implementation and feature certain parameters.

In the workflow, the process starts by creating a record with a new payment, once the author approves the request. After being reviewed by colleagues it progresses to a "canceled" or "paid" state. Furthermore, when the manager gives approval, the system checks the amount of the vacation advance. If it exceeds 1000, an additional signature from the big boss is required. The big boss also has the authority to adjust the advance amount or cancel the request.