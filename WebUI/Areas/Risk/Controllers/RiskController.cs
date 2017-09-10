using Business.Abstract;
using Business.Concrete;
using Business.Infrastructure;
using Common.Enums;
using MvcSiteMapProvider;
using MvcSiteMapProvider.Web.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using WebUI.Areas.Risk.Models.Risk;
using WebUI.Areas.Risk.Models.RiskImpact;
using WebUI.Areas.Risk.Models.RiskMitigation;
using WebUI.Controllers;
using WebUI.Models;

namespace WebUI.Areas.Risk.Controllers
{
    public class RiskController : MyController
    {
        public IRiskRepository RiskRepo;
        public IRiskImpactRepository RiskImpactRepo;
        public IRiskMitigationRepository RiskMitigationRepo;

        public RiskController(ILogRepository repoLog, IRiskRepository riskRepo, IRiskImpactRepository riskImpactRepo, IRiskMitigationRepository riskMitigationRepo)
            : base(repoLog)
        {
            RiskRepo = riskRepo;
            RiskImpactRepo = riskImpactRepo;
            RiskMitigationRepo = riskMitigationRepo;
        }

        // GET: Risk/Risk        
        [MvcSiteMapNode(Title = "Risk", ParentKey = "IndexHome", Key = "IndexRisk")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult Index(int? year)
        {
            if (year == null) year = DateTime.Now.Year;
            ViewBag.Risks = GoToIndex(year);
            return View("Index", new RiskPresentationStub() { Year = year.Value });
        }

        private List<RiskPresentationStub> GoToIndex(int? year)
        {
            //kamus
            Session["target"] = "target125";
            List<RiskPresentationStub> risks = new List<RiskPresentationStub>();

            EnumHelper eh = new EnumHelper();
            List<SortingInfo> sortings = new List<SortingInfo>();

            //algoritma
            //if (year != null) risk.Year = year.Value;

            var filters = new Business.Infrastructure.FilterInfo
            {
                Logic = "and",
                Filters = new List<Business.Infrastructure.FilterInfo>()
            };
            filters.Filters.Add(new Business.Infrastructure.FilterInfo
            {
                Field = "Year",
                Operator = "eq",
                Value = year.Value.ToString()
            });

            var sorting = new Business.Infrastructure.SortingInfo
            {
                SortOn = "RiskId",
                SortOrder = "ASC"
            };
            sortings.Add(sorting);

            List<Business.Entities.Risk> risks_temp = RiskRepo.Find(null, null, sortings, filters, true);
            foreach (Business.Entities.Risk risk in risks_temp)
            {
                RiskPresentationStub riskPresentationStub = new RiskPresentationStub(risk);

                riskPresentationStub.RiskImpacts = GetRiskImpacts(risk.RiskId);
                riskPresentationStub.RiskMitigations = GetRiskMitigations(risk.RiskId);

                risks.Add(riskPresentationStub);
            }
            
            return risks;
        }

        [MvcSiteMapNode(Title = "Detail Risiko", ParentKey = "IndexRisk", Key = "riskDetail")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult RiskDetail(int riskId)
        {
            ViewBag.riskImpacts = GetRiskImpacts(riskId);
            ViewBag.riskMitigations = GetRiskMitigations(riskId);

            RiskFormStub model = new RiskFormStub(RiskRepo.FindByPk(riskId));
            return View("_RiskDetails", model);
        }
        
        [MvcSiteMapNode(Title = "Tambah Risiko", ParentKey = "IndexRisk", Key = "addRisk")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult AddRisk()
        {
            RiskFormStub models = new RiskFormStub();
            ViewBag.Title = "Tambah Risiko";

            return View("_FormRisk", models);
        }
        [HttpPost]
        public async Task<ActionResult> AddRisk(RiskFormStub model)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.Risk dbItem = new Business.Entities.Risk();

            model.CreatedBy = model.ModifiedBy = User.UserName;
            model.CreatedDate = model.ModifiedDate = DateTime.Now;

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskRepo.CreateAsync(dbItem);

                if (RiskRepo.Id != 0)
                {
                    model.RiskId = RiskRepo.Id;

                    ViewBag.riskImpacts = GetRiskImpacts(model.RiskId);
                    ViewBag.riskMitigations = GetRiskMitigations(model.RiskId);

                    return View("_RiskDetails", model);
                }
                else
                {
                    return View("_FormRisk", model);
                }
            }
            else
            {
                return View("_FormRisk", model);
            }
        }


        [MvcSiteMapNode(Title = "Ubah Risiko", ParentKey = "IndexRisk", Key = "editRisk")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult EditRisk(int id)
        {
            RiskFormStub models = new RiskFormStub(RiskRepo.FindByPk(id));
            ViewBag.Title = "Ubah Risiko";

            return View("_FormRisk", models);
        }
        [HttpPost]
        public async Task<ActionResult> EditRisk(RiskFormStub model)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.Risk dbItem = new Business.Entities.Risk();

            model.ModifiedBy = User.UserName;
            model.ModifiedDate = DateTime.Now;

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskRepo.UpdateAsync(dbItem);

                if (RiskRepo.Id != 0)
                {
                    model.RiskId = RiskRepo.Id;

                    ViewBag.riskImpacts = GetRiskImpacts(model.RiskId);
                    ViewBag.riskMitigations = GetRiskMitigations(model.RiskId);

                    return View("_RiskDetails", model);
                }
                else
                {
                    return View("_FormRisk", model);
                }
            }
            else
            {
                return View("_FormRisk", model);
            }
        }


        [MvcSiteMapNode(Title = "Tambah Mitigasi", ParentKey = "IndexRisk", Key = "addRiskMitigation")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult AddRiskMitigation(int riskId)
        {
            RiskMitigationFormStub models = new RiskMitigationFormStub();
            models.RiskEvent = RiskRepo.FindByPk(riskId).RiskEvent;
            ViewBag.Title = "Tambah Mitigasi";

            return View("_FormRiskMitigation", models);
        }
        [HttpPost]
        public async Task<ActionResult> AddRiskMitigation(RiskMitigationFormStub model)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskMitigation dbItem = new Business.Entities.RiskMitigation();

            model.CreatedBy = model.ModifiedBy = User.UserName;
            model.CreatedDate = model.ModifiedDate = DateTime.Now;

            RiskFormStub riskModel = new RiskFormStub(RiskRepo.FindByPk(model.RiskId));

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskMitigationRepo.CreateAsync(dbItem);

                if (RiskMitigationRepo.Id != 0)
                {
                    ViewBag.riskImpacts = GetRiskImpacts(model.RiskId);
                    ViewBag.riskMitigations = GetRiskMitigations(model.RiskId);

                    return View("_RiskDetails", riskModel);
                }
                else
                {
                    return View("_RiskDetails", riskModel);
                }
            }
            else
            {
                return View("_RiskDetails", riskModel);
            }
        }


        [MvcSiteMapNode(Title = "Ubah Mitigasi", ParentKey = "IndexRisk", Key = "editRiskMitigation")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult EditRiskMitigation(int id)
        {
            RiskMitigationFormStub models = new RiskMitigationFormStub(RiskMitigationRepo.FindByPk(id));
            ViewBag.Title = "Ubah Mitigasi";

            return View("_FormRiskMitigation", models);
        }
        [HttpPost]
        public async Task<ActionResult> EditRiskMitigation(RiskMitigationFormStub model)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskMitigation dbItem = new Business.Entities.RiskMitigation();

            model.ModifiedBy = User.UserName;
            model.ModifiedDate = DateTime.Now;

            RiskFormStub riskModel = new RiskFormStub(RiskRepo.FindByPk(model.RiskId));

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskMitigationRepo.UpdateAsync(dbItem);

                if (RiskMitigationRepo.Id != 0)
                {
                    ViewBag.riskImpacts = GetRiskImpacts(model.RiskId);
                    ViewBag.riskMitigations = GetRiskMitigations(model.RiskId);

                    return View("_RiskDetails", riskModel);
                }
                else
                {
                    return View("_FormRiskMitigation", model);
                }
            }
            else
            {
                return View("_FormRiskMitigation", model);
            }
        }
        
        [HttpPost]
        public async Task<ActionResult> DeleteRiskMitigation(int id)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskMitigation dbItem = new Business.Entities.RiskMitigation();

            RiskMitigationFormStub model = new RiskMitigationFormStub(RiskMitigationRepo.FindByPk(id));
            model.IsDeleted = true;

            RiskFormStub riskModel = new RiskFormStub(RiskRepo.FindByPk(model.RiskId));

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskMitigationRepo.UpdateAsync(dbItem);

                if (RiskMitigationRepo.Id != 0)
                {
                    ViewBag.riskImpacts = GetRiskImpacts(model.RiskId);
                    ViewBag.riskMitigations = GetRiskMitigations(model.RiskId);

                    return View("_RiskDetails", riskModel);
                }
                else
                {
                    return View("_FormRiskMitigation", model);
                }
            }
            else
            {
                return View("_FormRiskMitigation", model);
            }
        }

        public List<RiskImpactFormStub> GetRiskImpacts(int riskId)
        {
            List<RiskImpactFormStub> riskImpacts = new List<RiskImpactFormStub>();

            //var filters = new Business.Infrastructure.FilterInfo
            //{
            //    Field = "RiskId",
            //    Operator = "eq",
            //    Value = riskId.ToString()
            //};
            foreach (Business.Entities.RiskImpact riskImpact in RiskImpactRepo.Find(null, null, null, null, false).FindAll(x => x.RiskId == riskId))
            {
                riskImpacts.Add(new RiskImpactFormStub(riskImpact));
            }

            return riskImpacts;
        }

        public List<RiskMitigationFormStub> GetRiskMitigations(int riskId)
        {
            List<RiskMitigationFormStub> riskMitigations = new List<RiskMitigationFormStub>();

            //var filters = new Business.Infrastructure.FilterInfo
            //{
            //    Field = "RiskId",
            //    Operator = "neq",
            //    Value = riskId.ToString()
            //};
            foreach (Business.Entities.RiskMitigation riskMitigation in RiskMitigationRepo.Find(null, null, null, null, false).FindAll(x => x.RiskId == riskId))
            {
                riskMitigations.Add(new RiskMitigationFormStub(riskMitigation));
            }
            return riskMitigations;
        }

    }
}