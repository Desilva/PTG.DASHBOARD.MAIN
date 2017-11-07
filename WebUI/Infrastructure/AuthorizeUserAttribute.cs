using Common.Enums;
using SecurityGuard.Interfaces;
using SecurityGuard.Services;
using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using WebUI.Infrastructure.Concrete;

namespace WebUI.Infrastructure
{
    public class AuthorizeUserAttribute : AuthorizeAttribute
    {
        private const string ERR_MSG = "Not valid type. Type must be {0}.";
        
        public object ModuleName { get; set; }

        public object ActionName { get; set; }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);

            //kamus
            string moduleName = null;
            string actionName = null;

            //algoritma
            if (ModuleName != null)
                if (ModuleName.GetType() != typeof(UserModule))
                    throw new InvalidCastException(string.Format(ERR_MSG, typeof(UserModule).Name));
            moduleName = ((UserModule)ModuleName).GetDescription();

            if (ActionName != null)
            {
                if (ActionName.GetType() != typeof(UserAction))
                    throw new InvalidCastException(string.Format(ERR_MSG, typeof(UserAction).Name));
                actionName = ((UserAction)ActionName).GetDescription();
            }

            if (filterContext.HttpContext.Request.IsAuthenticated)
            {
                var user = filterContext.HttpContext.User as ApplicationPrincipal;
                bool hasAccess = true;

                if (!string.IsNullOrEmpty(moduleName) && !string.IsNullOrEmpty(actionName))
                    hasAccess = user.Modules.Any(m => m.ModuleName == moduleName && m.ActionName == actionName);
                else if (!string.IsNullOrEmpty(moduleName) && string.IsNullOrEmpty(actionName))
                    hasAccess = user.Modules.Any(m => m.ModuleName == moduleName);
                else
                    hasAccess = false;

                if (!hasAccess)
                {
                    filterContext.Result = new RedirectToRouteResult(new
                        RouteValueDictionary(new
                        {
                            action = "Http401",
                            controller = "Error",
                            area = string.Empty,
                            url = filterContext.HttpContext.Request.Url.OriginalString
                        }));
                }
            }
        }
    }
}