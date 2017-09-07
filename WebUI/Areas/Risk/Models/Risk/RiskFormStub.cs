using Business.Entities;
using Common.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebUI.Areas.Risk.Models.RiskImpact;
using WebUI.Areas.Risk.Models.RiskMitigation;

namespace WebUI.Areas.Risk.Models.Risk
{
    public class RiskFormStub
    {    

        public RiskFormStub()
        {
            FillQualitatifQuantitatifRiskOptions();
            FillRiskClasificationOptions();
        }
        public RiskFormStub(Business.Entities.Risk risk)
        {
            RiskId                       = risk.RiskId;
            Controll                     = risk.Controll;
            KRI                          = risk.KRI;
            ProcessBusiness              = risk.ProcessBusiness;
            QualitatifImpact             = risk.QualitatifImpact;
            QualitatifQuantitatifRisk    = risk.QualitatifQuantitatifRisk;
            RiskAgent                    = risk.RiskAgent;
            RiskCategory                 = risk.RiskCategory;
            RiskClasification            = risk.RiskClasification;
            RiskEvent                    = risk.RiskEvent;
            RiskImpacts                  = risk.RiskImpacts;
            RiskMitigations              = risk.RiskMitigations;
            RiskNumber                   = risk.RiskNumber;
            Year                         = risk.Year;
            ModifiedBy                   = risk.ModifiedBy;
            ModifiedDate                 = risk.ModifiedDate;
            CreatedBy                    = risk.CreatedBy;
            CreatedDate                  = risk.CreatedDate;

            FillQualitatifQuantitatifRiskOptions();
            FillRiskClasificationOptions();
        }

        public void FillQualitatifQuantitatifRiskOptions()
        {
            QualitatifQuantitatifRiskOptions = new List<SelectListItem>();

            EnumHelper eh = new EnumHelper();
            QualitatifQuantitatifRiskOptions = Enum.GetValues(typeof(Measurement)).Cast<Measurement>().Select(x => new SelectListItem
            {
                Text = eh.GetEnumDescription((Measurement)Enum.Parse(typeof(Measurement), x.ToString())),
                Value = x.ToString()
            }).ToList();
        }

        public void FillRiskClasificationOptions()
        {
            RiskClasificationOptions = new List<SelectListItem>();

            EnumHelper eh = new EnumHelper();
            RiskClasificationOptions = Enum.GetValues(typeof(RiskClasification)).Cast<RiskClasification>().Select(x => new SelectListItem
            {
                Text = eh.GetEnumDescription((RiskClasification)Enum.Parse(typeof(RiskClasification), x.ToString())),
                Value = x.ToString()
            }).ToList();
        }


        public int RiskId { get; set; }
        public int Year { get; set; }
        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "Proses Bisnis")]
        public string ProcessBusiness { get; set; }
        [Display(Name = "Kategori Risiko")]
        public string RiskCategory { get; set; }
        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "Kejadian Risiko (Risk Event)")]
        public string RiskEvent { get; set; }
        [Display(Name = "Penyebab Risiko (Risk Agent)")]
        public string RiskAgent { get; set; }
        [Display(Name = "Gejala Risiko (KRI)")]
        public string KRI { get; set; }
        [Display(Name = "Faktor Positif (Control)")]
        public string Controll { get; set; }
        [Display(Name = "Dampak Kualitatif")]
        public string QualitatifImpact { get; set; }

        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "Klasifikasi Risiko")]
        public string RiskClasification { get; set; }
        public List<SelectListItem> RiskClasificationOptions { get; set; }

        [Display(Name = "Risiko Kualitatif / Kuantitatif")]
        public string QualitatifQuantitatifRisk { get; set; }
        public List<SelectListItem> QualitatifQuantitatifRiskOptions { get; set; }

        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "No.")]
        public string RiskNumber { get; set; }

        
        public Business.Entities.Risk GetDbObject()
        {
            Business.Entities.Risk dbItem = new Business.Entities.Risk();
            dbItem.RiskId = RiskId;
            dbItem.Controll = Controll;
            dbItem.KRI = KRI;
            dbItem.ProcessBusiness = ProcessBusiness;
            dbItem.QualitatifImpact = QualitatifImpact;
            dbItem.QualitatifQuantitatifRisk = QualitatifQuantitatifRisk;
            dbItem.RiskAgent = RiskAgent;
            dbItem.RiskCategory = RiskCategory;
            dbItem.RiskClasification = RiskClasification;
            dbItem.RiskEvent = RiskEvent;
            dbItem.RiskImpacts = RiskImpacts;
            dbItem.RiskMitigations = RiskMitigations;
            dbItem.RiskNumber = RiskNumber;
            dbItem.Year = Year;
            dbItem.ModifiedBy = ModifiedBy;
            dbItem.ModifiedDate = ModifiedDate;
            dbItem.CreatedBy = CreatedBy;
            dbItem.CreatedDate = CreatedDate;

            return dbItem;
        }

        //public void GetRiskMitigations()
        //{
        //    List<RiskImpactFormStub> riskImpacts = new List<RiskImpactFormStub>();
        //    List<RiskMitigationFormStub> riskMitigations = new List<RiskMitigationFormStub>();

        //    foreach (Business.Entities.RiskImpact riskImpact in RiskImpactRepo.Find().Where(x => x.RiskId == id))
        //    {
        //        riskImpacts.Add(new RiskImpactFormStub(riskImpact));
        //    }
        //    RiskImpacts = riskImpacts;

        //    foreach (Business.Entities.RiskMitigation riskMitigation in RiskMitigationRepo.Find().Where(x => x.RiskId == id))
        //    {
        //        riskMitigations.Add(new RiskMitigationFormStub(riskMitigation));
        //    }
        //    RiskMitigations = riskMitigations;
        //}

        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<bool> IsDeleted { get; set; }

        //public List<RiskImpactFormStub> RiskImpacts;
        //public List<RiskMitigationFormStub> RiskMitigations;

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Business.Entities.RiskImpact> RiskImpacts { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Business.Entities.RiskMitigation> RiskMitigations { get; set; }
    }
}