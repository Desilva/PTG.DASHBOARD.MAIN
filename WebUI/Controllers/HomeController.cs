﻿using Business.Abstract;
using MvcSiteMapProvider;
using MvcSiteMapProvider.Web.Mvc.Filters;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Configuration;
using WebUI.Models;
using System.Text;
using WebUI.Infrastructure;
using Common.Enums;

namespace WebUI.Controllers
{    
    public class HomeController : MyController
    {
        string LINK_FIN = ConfigurationManager.AppSettings["URL_API_PTGFIN_DASHBOARD"];
        string LINK_OPS = ConfigurationManager.AppSettings["URL_API_PTGOPS_DASHBOARD"];
        string LINK_INV = ConfigurationManager.AppSettings["URL_API_PTGINV_DASHBOARD"];

        public HomeController(ILogRepository repoLog)
            : base(repoLog)
        {
        }

        //
        // GET: /Dashboard/
        [MvcSiteMapNode(Title = "Home", ParentKey = "Dashboard", Key = "IndexHome")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult Index(int? year)
        {
            //HomeFinanceModel homeFinanceModel = new HomeFinanceModel();
            //HomeOperationModel homeOperationModel = new HomeOperationModel();

            //Task<HomeFinanceModel> homeFinanceModelTask = GetFinanceInfo();
            //Task<HomeOperationModel> homeOperationModelTask = GetOperationInfo();

            //await Task.WhenAll(homeFinanceModelTask, homeOperationModelTask);

            //ViewBag.HomeFinanceModel = homeFinanceModelTask.Result;
            //ViewBag.HomeOperationModel = homeOperationModelTask.Result;
            
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> GetFinanceInfo()
        {
            string requestContent = string.Empty;
            StringContent content = new StringContent(requestContent, Encoding.UTF8, "application/json");

            HttpClient client = new HttpClient();
            HttpResponseMessage response = new HttpResponseMessage();
            string respString = "";
            HomeResponseModel homeResponseModel = new HomeResponseModel();
            try
            {
                response = await client.GetAsync(LINK_FIN);
                if (response.IsSuccessStatusCode)
                {
                    respString = await response.Content.ReadAsStringAsync();
                }
            }
            catch (HttpRequestException e)
            {
                // Handle exception.
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            if (respString != "") homeResponseModel = serializer.Deserialize<HomeResponseModel>(respString);

            if (homeResponseModel.status == 200)
            {
                if (homeResponseModel.message == "Data found")
                {
                    if (homeResponseModel.data.Count() > 0)
                    {
                        return PartialView("_FinanceIndex", new HomeFinanceModel(homeResponseModel.data.FirstOrDefault()));
                    }
                }
            }

            return PartialView("_FinanceIndex", new HomeFinanceModel());
        }

        [HttpPost]
        public async Task<ActionResult> GetOperationInfo()
        {
            string requestContent = string.Empty;
            StringContent content = new StringContent(requestContent, Encoding.UTF8, "application/json");

            HttpClient client = new HttpClient();
            HttpResponseMessage response = new HttpResponseMessage();
            string respString = "";
            HomeResponseModel homeResponseModel = new HomeResponseModel();
            try
            {
                response = await client.GetAsync(LINK_OPS);
                if (response.IsSuccessStatusCode)
                {
                    respString = await response.Content.ReadAsStringAsync();
                }
            }
            catch (HttpRequestException e)
            {
                // Handle exception.
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            if (respString != "") homeResponseModel = serializer.Deserialize<HomeResponseModel>(respString);

            if (homeResponseModel.status == 200)
            {
                if (homeResponseModel.message == "Data found")
                {
                    if (homeResponseModel.data.Count() > 0)
                    {
                        return PartialView("_OperationIndex", new HomeOperationModel(homeResponseModel.data.FirstOrDefault()));
                    }
                }
            }

            return PartialView("_OperationIndex", new HomeOperationModel());
        }

        [HttpPost]
        public async Task<ActionResult> GetInvestmentInfo()
        {
            string requestContent = string.Empty;
            StringContent content = new StringContent(requestContent, Encoding.UTF8, "application/json");

            HttpClient client = new HttpClient();
            HttpResponseMessage response = new HttpResponseMessage();
            string respString = "";
            HomeInvestmentResponseModel homeResponseModel = new HomeInvestmentResponseModel();
            try
            {
                response = await client.GetAsync(LINK_INV);
                if (response.IsSuccessStatusCode)
                {
                    respString = await response.Content.ReadAsStringAsync();
                }
            }
            catch (HttpRequestException e)
            {
                // Handle exception.
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            if (respString != "") homeResponseModel = serializer.Deserialize<HomeInvestmentResponseModel>(respString);

            if (homeResponseModel.status == 200)
            {
                if (homeResponseModel.message == "Data found")
                {
                    if (homeResponseModel.data != null)
                    {
                        ViewBag.IsFound = true;
                        return PartialView("_InvestmentIndex", new HomeInvestmentModel(homeResponseModel.data));
                    }
                }
            }

            ViewBag.IsFound = false;
            return PartialView("_InvestmentIndex", new HomeInvestmentModel());
        }
    }
}
