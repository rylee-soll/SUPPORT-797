using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;
using WF.Sample.Business.DataAccess;

namespace WF.Sample.Business.Workflow.Conditions;

public class CheckAmountMoreThen : ICondition
{
    public CheckAmountMoreThen(IPaymentRepository payments)
    {
        _payments = payments;
    }

    public string Name => GetType().Name;
    public List<string> ExcludedSchemes => new();

    public async Task<bool> ExecuteAsync(ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token)
    {
        var amount = String.IsNullOrWhiteSpace(actionParameter) ? 0 : JsonConvert.DeserializeObject<int>(actionParameter);
        var payment = await _payments.GetAsync(processInstance.ProcessId);
        return payment.Amount > amount;
    }

    private readonly IPaymentRepository _payments;
}