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
    
    public partial class bs_SectorOKVED
    {
        public bs_SectorOKVED()
        {
            this.bs_Clients = new HashSet<Clients>();
        }
    
        public int SectorOKVEDID { get; set; }
        public string SectorOKVEDName { get; set; }
    
        public virtual ICollection<Clients> bs_Clients { get; set; }
    }
}
