using System;
using System.Collections.Generic;
using WebUI.Infrastructure;

namespace WebUI.Areas.Services.Models
{
    public class UserServiceModel
    {
        public Guid id { get; set; }
        public string username { get; set; }
        public List<string> rolename { get; set; }
        public string email { get; set; }
        //public List<ModuleAction> moduleAccess { get; set; }
        public string employeeName { get; set; }
    }
}