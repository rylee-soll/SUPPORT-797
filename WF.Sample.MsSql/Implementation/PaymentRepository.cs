using System;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using WF.Sample.Business.DataAccess;
using WF.Sample.Business.Model;

namespace WF.Sample.MsSql.Implementation;

public class PaymentRepository : IPaymentRepository
{
    public PaymentRepository(SampleContext sampleContext)
    {
        Db = sampleContext;
    }

    private SampleContext Db { get; set; }

    public async Task<Business.Model.Payment> GetAsync(Guid id)
    {
        return Mappings.Mapper.Map<Business.Model.Payment>(await Get(id));
    }

    public Task CreateAsync(Business.Model.Document document, decimal amount)
    {
        var payment = new Payment
        {
            Id = document.Id,
            State = "Requested",
            Amount = amount,
            RecipientId = document.AuthorId
        };

        Db.Payments.Add(payment);
        return Db.SaveChangesAsync();
    }

    public async Task SetState(Guid id, PaymentState state)
    {
        var payment = await Get(id);
        payment.State = state.ToString();
        await Db.SaveChangesAsync();
    }

    public async Task SetAmount(Guid id, decimal amount)
    {
        var payment = await Get(id);
        payment.Amount = amount;
        await Db.SaveChangesAsync();
    }

    private Task<Payment> Get(Guid id)
    {
        return Db.Payments
            .Include(p => p.Recipient)
            .FirstOrDefaultAsync(p => p.Id == id);
    }
}