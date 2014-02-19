
namespace WebApplication1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using System.Web;

    [MetadataType(typeof(ClientsMD))]
    public partial class bs_Clients
    {

        public class ClientsMD
        {
            [Display(Name = "Client Name")]
            public string Name;
            [Display(Name = "Address Contact")]
            public string Address;
            [Display(Name = "Primary Contact")]
            public string PrimaryContact;

            [Display(Name = "Country of Risk")]
            public Nullable<int> CountryOfRiskID;

            [Display(Name = "GICS Industry Code")]
            public int GICSSubIndustryID;

            [Display(Name = "Sector")]
            public int SectorBankID;

            [Display(Name = "Sector OKVED")]
            public int SectorOKVEDID;

            [Display(Name = "Category")]
            public int CategoryID;
    
            //public string PrimaryContact2;
            //public object NoSuchProperty { get; set; }

  
  
        }
    }
}