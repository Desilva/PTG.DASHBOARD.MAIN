using Business.Abstract;
using Business.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebUI.Controllers;

namespace WebUI.Areas.Risk.Controllers
{
    public class RiskController : MyController
    {
        public IRiskRepository RiskRepo;

        public RiskController(ILogRepository repoLog, IRiskRepository riskRepo)
            : base(repoLog)
        {
            RiskRepo = riskRepo;
        }

        // GET: Risk/Risk
        public ActionResult Index()
        {
            return View();
        }
    }
}