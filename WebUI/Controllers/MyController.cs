using Business.Abstract;
using SecurityGuard.Interfaces;
using SecurityGuard.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using WebUI.Infrastructure;
using WebUI.Infrastructure.Concrete;

namespace WebUI.Controllers
{
    [Authorize]
    //[LogActionFilter]
    public abstract class MyController : Controller
    {
        private const string USER_LOGIN = "USER_LOGIN";
        public ILogRepository RepoLog;

        protected string AppAddress
        {
            get
            {
                string result = Request.ApplicationPath == "/" ?
                    string.Format("{0}://{1}/", Request.Url.Scheme, Request.Url.Authority) :
                    string.Format("{0}://{1}{2}/", Request.Url.Scheme, Request.Url.Authority, Request.ApplicationPath);
                return result;
            }
        }

        #region Application Principal

        protected virtual new ApplicationPrincipal User
        {
            get
            {
                if (base.User.Identity.IsAuthenticated)
                {
                    if (Session[USER_LOGIN] as ApplicationPrincipal != null)
                        HttpContext.User = Session[USER_LOGIN] as ApplicationPrincipal;
                    else
                    {
                        HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
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
                            Session[USER_LOGIN] = appUser;
                            HttpContext.User = appUser;
                        }
                        else
                        {
                            FormsAuthentication.SignOut();
                            Response.Redirect(FormsAuthentication.LoginUrl, true);
                        }
                    }
                }
                else
                {
                    FormsAuthentication.SignOut();
                    Response.Redirect(FormsAuthentication.LoginUrl, true);
                }
                return HttpContext.User as ApplicationPrincipal;
            }
        }
        #endregion

        public MyController(ILogRepository repoLog)
        {
            RepoLog = repoLog;
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            base.OnActionExecuted(filterContext);
            
            if (Session[USER_LOGIN] as ApplicationPrincipal == null)
                HttpContext.User = User;
            ViewBag.AppAddress = AppAddress;
        }

        #region Http404 handling

        protected override void HandleUnknownAction(string actionName)
        {
            // If controller is ErrorController dont 'nest' exceptions
            if (this.GetType() != typeof(ErrorController))
                this.InvokeHttp404(HttpContext);
        }

        public ActionResult InvokeHttp404(HttpContextBase httpContext)
        {
            IController errorController = DependencyResolver.Current.GetService<ErrorController>();
            var errorRoute = new RouteData();
            errorRoute.Values.Add("controller", "Error");
            errorRoute.Values.Add("action", "Http404");
            errorRoute.Values.Add("url", httpContext.Request.Url.OriginalString);
            errorController.Execute(new RequestContext(
                 httpContext, errorRoute));

            return new EmptyResult();
        }

        #endregion
    }
}
