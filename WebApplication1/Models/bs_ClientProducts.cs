//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication1.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class bs_ClientProducts
    {
        public bs_ClientProducts()
        {
            this.bs_ClientFTPRates = new HashSet<bs_ClientFTPRates>();
        }
    
        public int CPID { get; set; }
        public Nullable<int> ClientID { get; set; }
        public int ClientEntityID { get; set; }
        public int ProductID { get; set; }
        public Nullable<System.DateTime> DateAgreed { get; set; }
        public System.DateTime DateIssued { get; set; }
        public Nullable<System.DateTime> DateEffective { get; set; }
    
        public virtual ICollection<bs_ClientFTPRates> bs_ClientFTPRates { get; set; }
    }
}
