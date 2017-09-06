using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebUI.Areas.SecurityGuard.Models.ServiceParameter
{
    public class FingerPrintParam
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public List<FingerPrintParam> listUser { get; set; }
    }
}