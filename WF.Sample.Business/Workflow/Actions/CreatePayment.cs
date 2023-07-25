using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;
using WF.Sample.Business.DataAccess;

namespace WF.Sample.Business.Workflow.Actions;

public class CreatePayment : IAction
{
    public CreatePayment(IDocumentRepository documents, IPaymentRepository payments)
    {
        _documents = documents;
        _payments = payments;
    }

    public string Name => GetType().Name;
    public List<string> ExcludedSchemes => new();

    public async Task ExecuteAsync(ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token)
    {
        Decimal.TryParse(actionParameter, out var amount);
        await _payments.CreateAsync(_documents.Get(processInstance.ProcessId), amount);
    }

    private readonly IDocumentRepository _documents;
    private readonly IPaymentRepository _payments;
}