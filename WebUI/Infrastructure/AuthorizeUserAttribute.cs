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
        private const string USER_LOGIN = "USER_LOGIN";

        public object ModuleName { get; set; }

        public object ActionName { get; set; }

        private ApplicationPrincipal User
        {
            get
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    if (HttpContext.Current.Session[USER_LOGIN] as ApplicationPrincipal != null)
                        HttpContext.Current.User = HttpContext.Current.Session[USER_LOGIN] as ApplicationPrincipal;
                    else
                    {
                        HttpCookie authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
                        FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                        IMembershipService membershipService = new MembershipService(Membership.Provider);
                        MembershipUser user = membershipService.GetUser(authTicket.Name);
                        if (user != null)
                        {
                            ApplicationPrincipal appUser = new ApplicationPrincipal(user.UserName);
                            appUser.UserId = user.ProviderUserKey.ToString();
                            appUser.UserName = user.UserName;
                            appUser.Email = user.Email;
                            appUser.Roles = System.Web.Security.Roles.GetRolesForUser(user.UserName).Any() ?
                                 System.Web.Security.Roles.GetRolesForUser(user.UserName).ToList() : null;
                            appUser.Modules = ModuleAction.GetModuleActionForUser(user.UserName);
                            HttpContext.Current.Session[USER_LOGIN] = appUser;
                            HttpContext.Current.User = appUser;
                        }
                        else
                        {
                            FormsAuthentication.SignOut();
                            HttpContext.Current.Response.Redirect(FormsAuthentication.LoginUrl, true);
                        }
                    }
                }
                else
                {
                    FormsAuthentication.SignOut();
                    HttpContext.Current.Response.Redirect(FormsAuthentication.LoginUrl, true);
                }
                return HttpContext.Current.User as ApplicationPrincipal;
            }
        }
        
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
                bool hasAccess = true;

                if (!string.IsNullOrEmpty(moduleName) && !string.IsNullOrEmpty(actionName))
                    hasAccess = User.Modules.Any(m => m.ModuleName == moduleName && m.ActionName == actionName);
                else if (!string.IsNullOrEmpty(moduleName) && string.IsNullOrEmpty(actionName))
                    hasAccess = User.Modules.Any(m => m.ModuleName == moduleName);
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