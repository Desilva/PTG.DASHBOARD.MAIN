using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Areas.Risk.Models.Risk
{
    public class RiskPresentationStub
    {        
        [Display(Name = "Periode")]
        public int Year { get; set; }
        public List<SelectListItem> YearOptions { get; set; }     

        public RiskPresentationStub()
        {
            IsDeleted = false;
            Year = DateTime.Now.Year;
            FillYearOptions();
        }
        public RiskPresentationStub(Business.Entities.Risk risk)
        {
            RiskId = risk.RiskId;
            Controll = risk.Controll;
            KRI = risk.KRI;
            ProcessBusiness = risk.ProcessBusiness;
            QualitatifImpact = risk.QualitatifImpact;
            QualitatifQuantitatifRisk = risk.QualitatifQuantitatifRisk;
            RiskAgent = risk.RiskAgent;
            RiskCategory = risk.RiskCategory;
            RiskClasification = risk.RiskClasification;
            RiskEvent = risk.RiskEvent;
            RiskNumber = risk.RiskNumber;
            Year = risk.Year;
            ModifiedBy = risk.ModifiedBy;
            ModifiedDate = risk.ModifiedDate;
            CreatedBy = risk.CreatedBy;
            CreatedDate = risk.CreatedDate;
            IsDeleted = risk.IsDeleted;

            FillYearOptions();
        }

        public void FillYearOptions()
        {
            YearOptions = new List<SelectListItem>();
            int year = DateTime.Now.Year;
            for(int i = int.Parse(ConfigurationManager.AppSettings["SystemYearStart"]); i<= (year); i++ )
            {
                YearOptions.Add(new SelectListItem { Value = i.ToString(), Text = i.ToString() });
            }
        }

        public int RiskId { get; set; }
        public string ProcessBusiness { get; set; }
        public string RiskCategory { get; set; }
        public string RiskEvent { get; set; }
        public string RiskAgent { get; set; }
        public string KRI { get; set; }
        public string Controll { get; set; }
        public string QualitatifImpact { get; set; }
        public string RiskClasification { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public string QualitatifQuantitatifRisk { get; set; }
        public string RiskNumber { get; set; }
        public Nullable<bool> IsDeleted { get; set; }

        public List<RiskImpact.RiskImpactFormStub> RiskImpacts { get; set; }
        public List<RiskMitigation.RiskMitigationFormStub> RiskMitigations { get; set; }
    }
}