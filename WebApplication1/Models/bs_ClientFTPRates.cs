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
    
    public partial class bs_ClientFTPRates
    {
        public int CFTPID { get; set; }
        public Nullable<int> ClientID { get; set; }
        public Nullable<int> ClientEntityID { get; set; }
        public Nullable<decimal> RateValue { get; set; }
        public Nullable<System.DateTime> DateEffective { get; set; }
        public Nullable<decimal> PmtFreq { get; set; }
        public Nullable<int> CCYID { get; set; }
        public Nullable<bool> Active { get; set; }
        public Nullable<int> ProductID { get; set; }
    
        public virtual bs_ClientProducts bs_ClientProducts { get; set; }
        public virtual bs_Clients bs_Clients { get; set; }
    }
}