//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication1
{
    using System;
    using System.Collections.Generic;
    
    public partial class Clients
    {
        public Clients()
        {
            this.bs_ClientLimits = new HashSet<bs_ClientLimits>();
            this.bs_ClientProducts = new HashSet<bs_ClientProducts>();
        }
    
        public int ClientID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string PrimaryContact { get; set; }
        public Nullable<int> CountryOfRiskID { get; set; }
        public Nullable<int> GICSSubIndustryID { get; set; }
        public int SectorBankID { get; set; }
        public int SectorOKVEDID { get; set; }
        public Nullable<int> CategoryID { get; set; }
    
        public virtual ICollection<bs_ClientLimits> bs_ClientLimits { get; set; }
        public virtual ICollection<bs_ClientProducts> bs_ClientProducts { get; set; }
        public virtual Sector_Bank bs_SectorBank { get; set; }
        public virtual bs_SectorOKVED bs_SectorOKVED { get; set; }
    }
}
