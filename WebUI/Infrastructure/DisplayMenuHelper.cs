using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ZII.AMS.Presentation.Infrastructure
{
    public static class DisplayMenuHelper
    {
        public static string GenerateMenuLink(string title, string controller, string action, string area, string currentController, string currentAction, string currentArea)
        {
            string template = "<li class=\"{2}\"><a href=\"{1}\">{0}</a></li>";
            string menu;
            string liClass = "";
            UrlHelper uh = new UrlHelper(HttpContext.Current.Request.RequestContext);
            string url = uh.Action(action, controller, new { area = area });

            if (currentArea.Equals(area, StringComparison.InvariantCultureIgnoreCase) && (currentController.Equals(controller, StringComparison.InvariantCultureIgnoreCase)) && (currentAction.Equals(action, StringComparison.InvariantCultureIgnoreCase)))
                liClass = "active";
            menu = string.Format(template, title, url, liClass);

            return menu;
        }
    }
}