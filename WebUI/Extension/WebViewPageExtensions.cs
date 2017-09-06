using SecurityGuard.Interfaces;
using SecurityGuard.Services;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebUI.Infrastructure.Concrete;

namespace WebUI.Extension
{
    public abstract class WebViewPageExtensions : WebViewPage
    {
        public virtual new ApplicationPrincipal User
        {
            get
            {
                return WebViewPageExtensionsHelper.GetCurrentUser;
            }
        }
    }

    public abstract class WebViewPageExtensions<TModel> : WebViewPage<TModel>
    {
        public virtual new ApplicationPrincipal User
        {
            get
            {
                return WebViewPageExtensionsHelper.GetCurrentUser;
            }
        }
    }

    internal static class WebViewPageExtensionsHelper
    {
        private const string USER_LOGIN = "USER_LOGIN";
        public static ApplicationPrincipal GetCurrentUser
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
                            //appUser.Roles = ; use method to get roles from db first then the objects will be store to session
                            //appUser.Modules = ; use method to get modules from db first then the objects will be store to session
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
    }
}