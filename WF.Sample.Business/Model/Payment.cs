using System;

namespace WF.Sample.Business.Model
{
    public class Payment
    {
        public Guid Id { get; set; }
        public PaymentState State { get; set; }
        public decimal Amount { get; set; }
        public Employee Recipient { get; set; }
    }
}