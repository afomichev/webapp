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
    
    public partial class bs_SectorBank
    {
        public bs_SectorBank()
        {
            this.bs_Clients = new HashSet<bs_Clients>();
        }
    
        public int SectorBankID { get; set; }
        public string SectorBankName { get; set; }
        public Nullable<int> GICSSubindustryID { get; set; }
        public Nullable<int> SectorOKVEDID { get; set; }
    
        public virtual ICollection<bs_Clients> bs_Clients { get; set; }
        public virtual bs_SectorOKVED bs_SectorOKVED { get; set; }
    }
}