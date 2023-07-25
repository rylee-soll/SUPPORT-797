using System;
using System.Threading.Tasks;
using WF.Sample.Business.Model;

namespace WF.Sample.Business.DataAccess;

public interface IPaymentRepository
{
    Task<Payment> GetAsync(Guid id);
    Task CreateAsync(Document document, decimal amount);
    Task SetState(Guid id, PaymentState state);
    Task SetAmount(Guid id, decimal amount);
}