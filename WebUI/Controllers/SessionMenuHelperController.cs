using Business.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    public class SessionMenuHelperController : MyController
    {
        public SessionMenuHelperController(ILogRepository repoLog)
            : base(repoLog)
        {
        }
        // GET: SessionMenuHelper
        public void Cookies(string option)
        {
            HttpCookie myCookie = new HttpCookie("targetOption", option);
            Response.Cookies.Add(myCookie);
            var absUri = Request.UrlReferrer.AbsoluteUri;

        }
    }
}