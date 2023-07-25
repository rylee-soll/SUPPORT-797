using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;
using WF.Sample.Business.DataAccess;
using WF.Sample.Business.Workflow.Actions;
using WF.Sample.Business.Workflow.Conditions;

namespace WF.Sample.Business.Workflow;

public class ActionProvider : IWorkflowActionProvider
{
    public ActionProvider(IDataServiceProvider services)
    {
        _services = services;
        
        _actions = new()
        {
            new CreatePayment(_services.Get<IDocumentRepository>(), _services.Get<IPaymentRepository>()),
            new CancelPayment(_services.Get<IPaymentRepository>()),
            new PayPayment(_services.Get<IPaymentRepository>()),
            new SetNewPaymentAmount(_services.Get<IPaymentRepository>()),
        };
        
        _conditions = new()
        {
            new CheckAmountMoreThen(_services.Get<IPaymentRepository>()),
        };
    }
    
    #region Actions

    public List<string> GetActions(string schemeCode, NamesSearchType namesSearchType)
    {
        return namesSearchType is NamesSearchType.NotExcluded
            ? _actions.Where(action => !action.ExcludedSchemes.Contains(schemeCode)).Select(action => action.Name).ToList()
            : _actions.Select(action => action.Name).ToList();
    }

    public bool IsActionAsync(string name, string schemeCode)
    {
        // We're using only async implementations
        return true;
    }
        
    public Task ExecuteActionAsync(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token)
    {
        return _actions.First(action => action.Name == name).ExecuteAsync(processInstance, runtime, actionParameter, token);
    }
        
    public void ExecuteAction(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter)
    {
        ExecuteActionAsync(name, processInstance, runtime, actionParameter, new CancellationToken()).Wait();
    }

    private List<IAction> _actions;

    #endregion

    #region Conditions

    public List<string> GetConditions(string schemeCode, NamesSearchType namesSearchType)
    {
        return namesSearchType is NamesSearchType.NotExcluded
            ? _conditions.Where(condition => !condition.ExcludedSchemes.Contains(schemeCode)).Select(condition => condition.Name).ToList()
            : _conditions.Select(condition => condition.Name).ToList();
    }

    public bool IsConditionAsync(string name, string schemeCode)
    {
        // We're using only async implementations
        return true;
    }
        
    public Task<bool> ExecuteConditionAsync(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token)
    {
        return _conditions.First(action => action.Name == name).ExecuteAsync(processInstance, runtime, actionParameter, token);
    }

    public bool ExecuteCondition(string name, ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter)
    {
        return ExecuteConditionAsync(name, processInstance, runtime, actionParameter, new CancellationToken()).Result;
    }

    private List<ICondition> _conditions;

    #endregion

    private readonly IDataServiceProvider _services;
}