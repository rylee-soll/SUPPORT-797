using System;
using System.ComponentModel.DataAnnotations;

namespace WF.Sample.MsSql;

public class Payment
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public Payment()
    {
            
    }

    public Guid Id { get; set; }

    [Required]
    [StringLength(32)]
    public string State { get; set; }
        
    public decimal Amount { get; set; }

    public Guid RecipientId { get; set; }

    public virtual Employee Recipient { get; set; }
}