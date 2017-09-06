using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using WebUI.Models;

namespace WebUI.Infrastructure.Abstract
{
    interface IApplicationPrincipal : IPrincipal
    {
        string UserId { get; set; }
        string UserName { get; set; }
        string Email { get; set; }
        List<string> Roles { get; set; }
        List<ModuleAction> Modules { get; set; }
        bool HasAccess(params string[] moduleNames);
    }
}