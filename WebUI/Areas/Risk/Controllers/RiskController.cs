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
using WebUI.Areas.Risk.Models.RiskDocument;
using WebUI.Controllers;
using WebUI.Models;

namespace WebUI.Areas.Risk.Controllers
{
    public class RiskController : MyController
    {
        public IRiskRepository RiskRepo;
        public IRiskImpactRepository RiskImpactRepo;
        public IRiskMitigationRepository RiskMitigationRepo;
        public IRiskDocumentRepository RiskDocumentRepo;

        public RiskController(ILogRepository repoLog, IRiskRepository riskRepo, IRiskImpactRepository riskImpactRepo, IRiskMitigationRepository riskMitigationRepo, IRiskDocumentRepository riskDocumentRepo)
            : base(repoLog)
        {
            RiskRepo = riskRepo;
            RiskImpactRepo = riskImpactRepo;
            RiskMitigationRepo = riskMitigationRepo;
            RiskDocumentRepo = riskDocumentRepo;
        }

        // GET: Risk/Risk        
        public ActionResult GetJsonRisks(int? year)
        {
            //ambil2in risk
            if (year == null) year = DateTime.Now.Year;
            List<RiskPresentationStub> listRisk = GoToIndex(year);
            
            return Json(listRisk, JsonRequestBehavior.AllowGet);
        }

        // GET: Risk/Risk        
        [MvcSiteMapNode(Title = "Risk", ParentKey = "IndexHome", Key = "IndexRisk")]
        [SiteMapTitle("Breadcrumb")]
        public async Task<ActionResult> Index(int? year)
        {
            //ambil2in risk
            if (year == null) year = DateTime.Now.Year;
            ViewBag.Risks = GoToIndex(year);

            //ambil2in risk document
            ViewBag.RiskDocuments = GetRiskDocuments();

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
                SortOrder = "DESC"
            };
            sortings.Add(sorting);

            List<Business.Entities.Risk> risks_temp = RiskRepo.Find(null, null, sortings, filters, false);
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
        public ActionResult AddRisk(int? year)
        {
            RiskFormStub model = new RiskFormStub();
            if (year == null) year = DateTime.Now.Year;
            model.Year = year.Value;
            ViewBag.Title = "Tambah Risiko";

            return View("_FormRisk", model);
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

        [HttpPost]
        public async Task<JsonResult> DeleteRisk(int id)
        {
            ResponseModel response = new ResponseModel(true);
            var dbItem = await RiskRepo.FindByPkAsync(id);
            try
            {
                dbItem.IsDeleted = true;
                await RiskRepo.UpdateAsync(dbItem);
                string template = HttpContext.GetGlobalResourceObject("MyGlobalMessage", "DeleteSuccess").ToString();
                string message = string.Format(template, dbItem.RiskEvent);
                response.Message = message;
                return Json(response);
            }
            catch (Exception)
            {
                response.SetFail("");
            }
            return Json(response);
        }

        // GET: Risk/Risk        
        public ActionResult GetJsonRiskMitigations(int? riskId)
        {
            return Json(GetRiskMitigations(riskId), JsonRequestBehavior.AllowGet);
        }

        [MvcSiteMapNode(Title = "Tambah Mitigasi", ParentKey = "IndexRisk", Key = "addRiskMitigation")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult AddRiskMitigation(int riskId)
        {
            RiskMitigationFormStub models = new RiskMitigationFormStub();
            models.RiskEvent = RiskRepo.FindByPk(riskId).RiskEvent;
            models.RiskId = riskId;
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
                    return View("_FormRiskMitigation", model);
                }
            }
            else
            {
                return View("_FormRiskMitigation", model);
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
        public async Task<JsonResult> DeleteRiskMitigation(int id)
        {
            ResponseModel response = new ResponseModel(true);
            var dbItem = await RiskMitigationRepo.FindByPkAsync(id);
            try
            {
                dbItem.IsDeleted = true;
                await RiskMitigationRepo.UpdateAsync(dbItem);
                string template = HttpContext.GetGlobalResourceObject("MyGlobalMessage", "DeleteSuccess").ToString();
                string message = string.Format(template, dbItem.MitigationPlan);
                response.Message = message;
                return Json(response);
            }
            catch (Exception)
            {
                response.SetFail("");
            }
            return Json(response);
        }

        [MvcSiteMapNode(Title = "Tambah Dampak", ParentKey = "IndexRisk", Key = "addRiskImpact")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult AddRiskImpact(int riskId)
        {
            List<RiskImpactFormStub> models = initListRiskImpactFormStub();
            foreach (RiskImpactFormStub model in models)
            {
                model.RiskEvent = RiskRepo.FindByPk(riskId).RiskEvent;
                model.RiskId = riskId;
            }
            ViewBag.Title = "Tambah Dampak";

            return View("_FormRiskImpact", models);
        }
        [HttpPost]
        public async Task<ActionResult> AddRiskImpact(List<RiskImpactFormStub> models)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskImpact dbItem = new Business.Entities.RiskImpact();
            int riskId = models.FirstOrDefault().RiskId;

            RiskFormStub riskModel = new RiskFormStub(RiskRepo.FindByPk(riskId));

            foreach (RiskImpactFormStub model in models)
            {
                model.CreatedBy = model.ModifiedBy = User.UserName;
                model.CreatedDate = model.ModifiedDate = DateTime.Now;

                if (ModelState.IsValid)
                {
                    dbItem = model.GetDbObject();
                    await RiskImpactRepo.CreateAsync(dbItem);
                }
                else
                {
                    return View("_FormRiskImpact", models);
                }
            }

            if (RiskImpactRepo.Id != 0)
            {
                ViewBag.riskImpacts = GetRiskImpacts(riskId);
                ViewBag.riskMitigations = GetRiskMitigations(riskId);

                return View("_RiskDetails", riskModel);
            }
            else
            {
                return View("_FormRiskImpact", models);
            }

        }


        [MvcSiteMapNode(Title = "Ubah Dampak", ParentKey = "IndexRisk", Key = "editRiskImpact")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult EditRiskImpact(int riskId)
        {
            var filters = new Business.Infrastructure.FilterInfo
            {
                Logic = "and",
                Filters = new List<Business.Infrastructure.FilterInfo>()
            };
            filters.Filters.Add(new Business.Infrastructure.FilterInfo
            {
                Field = "RiskId",
                Operator = "eq",
                Value = riskId.ToString()
            });
            var sortings = new List<SortingInfo>();
            sortings.Add(new SortingInfo
            {
                SortOn = "Type",
                SortOrder = "ASC"
            });
            List<RiskImpactFormStub> models = makeListRiskImpactFormStub(RiskImpactRepo.Find(null, null, sortings, filters, false));
            string riskEvent = RiskRepo.FindByPk(riskId).RiskEvent;
            foreach (RiskImpactFormStub model in models)
            {
                model.RiskEvent = riskEvent;
            }
            ViewBag.Title = "Ubah Dampak";

            return View("_FormRiskImpact", models);
        }
        [HttpPost]
        public async Task<ActionResult> EditRiskImpact(List<RiskImpactFormStub> models)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskImpact dbItem = new Business.Entities.RiskImpact();
            int riskId = models.FirstOrDefault().RiskId;

            RiskFormStub riskModel = new RiskFormStub(RiskRepo.FindByPk(riskId));

            foreach (RiskImpactFormStub model in models)
            {
                model.ModifiedBy = User.UserName;
                model.ModifiedDate = DateTime.Now;

                if (ModelState.IsValid)
                {
                    dbItem = model.GetDbObject();
                    await RiskImpactRepo.UpdateAsync(dbItem);
                }
                else
                {
                    return View("_FormRiskImpact", models);
                }
            }

            if (RiskImpactRepo.Id != 0)
            {
                ViewBag.riskImpacts = GetRiskImpacts(riskId);
                ViewBag.riskMitigations = GetRiskMitigations(riskId);

                return View("_RiskDetails", riskModel);
            }
            else
            {
                return View("_FormRiskImpact", models);
            }
        }

        //public ActionResult RenderRiskDocument()
        //{
        //    //ambil2in risk documents
        //    List<RiskDocumentPresentationStub> listRiskDocuments = GetRiskDocuments();

        //    return PartialView("_RiskDocument", listRiskDocuments);
        //}

        [MvcSiteMapNode(Title = "Tambah Dokumen", ParentKey = "IndexRisk", Key = "addRiskDocument")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult AddRiskDocument()
        {
            RiskDocumentFormStub models = new RiskDocumentFormStub();
            ViewBag.Title = "Tambah Dokumen";

            return View("_FormRiskDocument", models);
        }
        [HttpPost]
        public async Task<ActionResult> AddRiskDocument(RiskDocumentFormStub model)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskDocument dbItem = new Business.Entities.RiskDocument();

            model.CreatedBy = model.ModifiedBy = User.UserName;
            model.CreatedDate = model.ModifiedDate = DateTime.Now;

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskDocumentRepo.CreateAsync(dbItem);

                if (RiskDocumentRepo.Id != 0)
                {
                    return await Index(null);
                }
                else
                {
                    return View("_FormRiskDocument", model);
                }
            }
            else
            {
                return View("_FormRiskDocument", model);
            }
        }


        [MvcSiteMapNode(Title = "Ubah Dokumen", ParentKey = "IndexRisk", Key = "editRiskDocument")]
        [SiteMapTitle("Breadcrumb")]
        public ActionResult EditRiskDocument(int id)
        {
            RiskDocumentFormStub models = new RiskDocumentFormStub(RiskDocumentRepo.FindByPk(id));
            ViewBag.Title = "Ubah Dokumen";

            return View("_FormRiskDocument", models);
        }
        [HttpPost]
        public async Task<ActionResult> EditRiskDocument(RiskDocumentFormStub model)
        {
            ResponseModel response = new ResponseModel(true);
            Business.Entities.RiskDocument dbItem = new Business.Entities.RiskDocument();

            model.ModifiedBy = User.UserName;
            model.ModifiedDate = DateTime.Now;

            RiskPresentationStub riskModel = new RiskPresentationStub();

            if (ModelState.IsValid)
            {
                dbItem = model.GetDbObject();
                await RiskDocumentRepo.UpdateAsync(dbItem);

                if (RiskDocumentRepo.Id != 0)
                {
                    return await Index(null);
                }
                else
                {
                    return View("_FormRiskDocument", model);
                }
            }
            else
            {
                return View("_FormRiskDocument", model);
            }
        }

        [HttpPost]
        public async Task<JsonResult> DeleteRiskDocument(int id)
        {
            ResponseModel response = new ResponseModel(true);
            FileNameProcessController fn = new FileNameProcessController();
            var dbItem = await RiskDocumentRepo.FindByPkAsync(id);
            try
            {
                dbItem.IsDeleted = true;
                await RiskDocumentRepo.UpdateAsync(dbItem);
                string template = HttpContext.GetGlobalResourceObject("MyGlobalMessage", "DeleteSuccess").ToString();
                string message = string.Format(template, fn.FriendlyName(dbItem.FilePath));
                response.Message = message;
                return Json(response);
            }
            catch (Exception)
            {
                response.SetFail("");
            }
            return Json(response);
        }

        public List<RiskImpactFormStub> initListRiskImpactFormStub()
        {
            List<RiskImpactFormStub> listRiskImpactFormStub = new List<RiskImpactFormStub>();
            EnumHelper eh = new EnumHelper();
            foreach (ImpactTypes impactTypes in Enum.GetValues(typeof(ImpactTypes)))
            {
                listRiskImpactFormStub.Add(new RiskImpactFormStub(impactTypes.ToString()));
            }
            return listRiskImpactFormStub;
        }

        public List<RiskImpactFormStub> makeListRiskImpactFormStub(List<Business.Entities.RiskImpact> riskImpacts)
        {
            List<RiskImpactFormStub> listRiskImpactFormStub = new List<RiskImpactFormStub>();
            foreach (Business.Entities.RiskImpact riskImpact in riskImpacts)
            {
                listRiskImpactFormStub.Add(new RiskImpactFormStub(riskImpact));
            }
            return listRiskImpactFormStub;
        }

        public List<RiskImpactFormStub> GetRiskImpacts(int? riskId)
        {
            List<RiskImpactFormStub> riskImpacts = new List<RiskImpactFormStub>();

            var filters = new Business.Infrastructure.FilterInfo
            {
                Logic = "and",
                Filters = new List<Business.Infrastructure.FilterInfo>()
            };
            if (riskId != null)
            {
                filters.Filters.Add(new Business.Infrastructure.FilterInfo
                {
                    Field = "RiskId",
                    Operator = "eq",
                    Value = riskId.ToString()
                });
            }
            List<SortingInfo> sortings = new List<SortingInfo>();
            sortings.Add(new SortingInfo
            {
                SortOn = "Type",
                SortOrder = "ASC"
            });
            foreach (Business.Entities.RiskImpact riskImpact in RiskImpactRepo.Find(null, null, sortings, filters, false))
            {
                riskImpacts.Add(new RiskImpactFormStub(riskImpact));
            }

            return riskImpacts;
        }

        public List<RiskMitigationFormStub> GetRiskMitigations(int? riskId)
        {
            List<RiskMitigationFormStub> riskMitigations = new List<RiskMitigationFormStub>();

            var filters = new Business.Infrastructure.FilterInfo
            {
                Logic = "and",
                Filters = new List<Business.Infrastructure.FilterInfo>()
            };
            if (riskId != null)
            {
                filters.Filters.Add(new Business.Infrastructure.FilterInfo
                {
                    Field = "RiskId",
                    Operator = "eq",
                    Value = riskId.ToString()
                });
            }
            foreach (Business.Entities.RiskMitigation riskMitigation in RiskMitigationRepo.Find(null, null, null, filters, false))
            {
                riskMitigations.Add(new RiskMitigationFormStub(riskMitigation));
            }
            return riskMitigations;
        }

        public List<RiskDocumentPresentationStub> GetRiskDocuments()
        {
            List<RiskDocumentPresentationStub> riskDocuments = new List<RiskDocumentPresentationStub>();
            
            foreach (Business.Entities.RiskDocument riskDocument in RiskDocumentRepo.Find())
            {
                riskDocuments.Add(new RiskDocumentPresentationStub(riskDocument));
            }
            return riskDocuments;
        }
    }
}