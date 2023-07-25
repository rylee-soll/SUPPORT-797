using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;
using WF.Sample.Business.DataAccess;
using WF.Sample.Business.Model;

namespace WF.Sample.Business.Workflow.Actions;

public class SetNewPaymentAmount : IAction
{
    public SetNewPaymentAmount(IPaymentRepository payments)
    {
        _payments = payments;
    }

    public string Name => GetType().Name;
    public List<string> ExcludedSchemes => new();

    public Task ExecuteAsync(ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token)
    {
        Decimal.TryParse(actionParameter, out var amount);
        return _payments.SetAmount(processInstance.ProcessId, amount);
    }
    
    private readonly IPaymentRepository _payments;
}