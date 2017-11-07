using System.Web.Mvc;
using WebUI.Infrastructure.Concrete;

namespace WebUI.Extension
{
    public abstract class WebViewPageExtensions : WebViewPage
    {
        public virtual new ApplicationPrincipal User
        {
            get
            {
                return base.User as ApplicationPrincipal;
            }
        }
    }

    public abstract class WebViewPageExtensions<TModel> : WebViewPage<TModel>
    {
        public virtual new ApplicationPrincipal User
        {
            get
            {
                return base.User as ApplicationPrincipal;
            }
        }
    }
}