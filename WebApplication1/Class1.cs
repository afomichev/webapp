using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ActivitiesModel.Meta
{
    [MetadataType(typeof(ClientsHelper))]
    public partial class Clients { }

    public class ClientsHelper
    {
        [Display(Name = "Client Name")]
        public string Name;
    }

}