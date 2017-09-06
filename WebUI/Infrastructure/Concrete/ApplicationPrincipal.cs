using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using WebUI.Infrastructure.Abstract;
using WebUI.Models;

namespace WebUI.Infrastructure.Concrete
{
    public class ApplicationPrincipal : IApplicationPrincipal
    {
        public IIdentity Identity { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public List<string> Roles { get; set; }
        public List<ModuleAction> Modules { get; set; }

        public ApplicationPrincipal() { }

        public ApplicationPrincipal(string username)
        {
            this.Identity = new GenericIdentity(username);
        }

        public bool IsInRole(string role)
        {
            return Identity != null && Identity.IsAuthenticated &&
              !string.IsNullOrWhiteSpace(role) && System.Web.Security.Roles.IsUserInRole(Identity.Name, role);
        }

        public bool HasAccess(params string[] moduleNames)
        {
            //kamus
            bool isHas = false;

            //algoritma
            if (this.Modules != null)
            {
                isHas = this.Modules.Where(m => moduleNames.Contains(m.ModuleName)).Count() > 0;
            }

            return isHas;
        }
    }

    public class CustomPrincipalSerializeModel
    {
        public List<ModuleAction> Modules { get; set; }
    }
}