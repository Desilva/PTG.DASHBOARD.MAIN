using Business.Abstract;
using Business.Entities;
using Common.Enums;
using MvcSiteMapProvider;
using MvcSiteMapProvider.Web.Mvc.Filters;
using SecurityGuard.Interfaces;
using SecurityGuard.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using WebUI.Infrastructure;
using WebUI.Infrastructure.Concrete;
using WebUI.Models;

namespace WebUI.Controllers
{
    public class HomeController : MyController
    {

        public HomeController(ILogRepository repoLog)
            : base(repoLog)
        {
        }

        //
        // GET: /Dashboard/
        [MvcSiteMapNode(Title = "Home", ParentKey = "Dashboard", Key = "IndexHome")]
        [SiteMapTitle("Breadcrumb")]
        public async Task<ActionResult> Index(int? year)
        {
            return View();
        }


        
    }
}
