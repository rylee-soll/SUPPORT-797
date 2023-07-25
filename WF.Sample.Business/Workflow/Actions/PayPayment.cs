using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;
using WF.Sample.Business.DataAccess;
using WF.Sample.Business.Model;

namespace WF.Sample.Business.Workflow.Actions;

public class PayPayment : IAction
{
    public PayPayment(IPaymentRepository payments)
    {
        _payments = payments;
    }

    public string Name => GetType().Name;
    public List<string> ExcludedSchemes => new();

    public Task ExecuteAsync(ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token)
    {
        return _payments.SetState(processInstance.ProcessId, PaymentState.Paid);
    }
    
    private readonly IPaymentRepository _payments;
}