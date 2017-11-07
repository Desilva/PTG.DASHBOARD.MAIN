using SecurityGuard.Interfaces;
using SecurityGuard.Services;
using System;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using WebUI.Infrastructure;
using WebUI.Infrastructure.Concrete;

namespace WebUI
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            DependencyResolver.SetResolver(new NinjectDependencyResolver());

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            ClientDataTypeModelValidatorProvider.ResourceClassKey = "MyGlobalErrors";
            DefaultModelBinder.ResourceClassKey = "MyGlobalErrors";
            DataAnnotationsModelValidatorProvider.AddImplicitRequiredAttributeForValueTypes = false;

            //model binder
            //ModelBinders.Binders.Add(typeof(UserLogin), new UserLoginModelBinder());
        }

        private void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();

            if (ex is HttpAntiForgeryException)
            {
                HttpContext httpContext = HttpContext.Current;
                string user = User.Identity.Name;
                Response.Clear();
                Server.ClearError(); //make sure you log the exception first
                //handle for logout
                if (user == null || user == "")
                    Response.Redirect(FormsAuthentication.LoginUrl, true);
                else
                {
                    httpContext.Response.Redirect("~/Error/AntiForgery", true);
                }
            }
        }

        protected void Application_PreRequestHandlerExecute(object sender, EventArgs e)
        {
            //Check if user is authenticated
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (!authTicket.Expired)
                {
                    if (HttpContext.Current.Session != null)
                    {
                        if (HttpContext.Current.Session[AuthenticationHelper.SessionName] == null)
                        {
                            IMembershipService membershipService = new MembershipService(Membership.Provider);
                            MembershipUser user = membershipService.GetUser(authTicket.Name);
                            if (user != null)
                            {
                                ApplicationPrincipal principal = new ApplicationPrincipal(user.UserName);
                                principal.UserId = user.ProviderUserKey.ToString();
                                principal.UserName = user.UserName;
                                principal.Email = user.Email;
                                principal.Roles = Roles.GetRolesForUser(user.UserName).Any() ?
                                    Roles.GetRolesForUser(user.UserName).ToList() : null;
                                principal.Modules = ModuleAction.GetModuleActionForUser(user.UserName);
                                HttpContext.Current.Session[AuthenticationHelper.SessionName] = principal;
                                HttpContext.Current.User = principal;
                            }
                        }
                        else
                        {
                            HttpContext.Current.User = HttpContext.Current.Session[AuthenticationHelper.SessionName] as ApplicationPrincipal;
                        }
                    }
                }
                else
                {
                    FormsAuthentication.SignOut();
                    Session.Clear();
                    Request.Cookies.Clear();
                    Response.Redirect(FormsAuthentication.LoginUrl, true);
                    return;
                }
            }
        }
    }
}