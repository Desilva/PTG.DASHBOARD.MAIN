using Business.Abstract;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using WebUI.Infrastructure.Concrete;

namespace WebUI.Controllers
{
    [Authorize]
    //[LogActionFilter]
    public abstract class MyController : Controller
    {
        public ILogRepository RepoLog { get; set; }
        
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
            
            ViewBag.AppAddress = AppAddress;
        }

        #region Http404 handling

        protected override void HandleUnknownAction(string actionName)
        {
            // If controller is ErrorController dont 'nest' exceptions
            if (GetType() != typeof(ErrorController))
                InvokeHttp404(HttpContext);
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
