using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebUI.Areas.Services.Models
{
    public class ServiceStub<T>
    {
        public int total { get; set; }
        public List<T> data { get; set; }
        public int status { get; set; }
        public string message { get; set; }
    }
}