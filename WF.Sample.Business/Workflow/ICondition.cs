using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using OptimaJet.Workflow.Core.Model;
using OptimaJet.Workflow.Core.Runtime;

namespace WF.Sample.Business.Workflow;

public interface ICondition
{
    string Name { get; }
    List<string> ExcludedSchemes { get; }
    Task<bool> ExecuteAsync(ProcessInstance processInstance, WorkflowRuntime runtime, string actionParameter, CancellationToken token);
}
