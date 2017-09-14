using Business.Entities;
using Common.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebUI.Controllers;

namespace WebUI.Areas.Risk.Models.RiskMitigation
{
    public class RiskMitigationFormStub
    {

        public RiskMitigationFormStub()
        {
            IsDeleted = false;
            FillMonthOptions();
        }
        public RiskMitigationFormStub(Business.Entities.RiskMitigation riskMitigation)
        {
            MitigationId        = riskMitigation.MitigationId;
            RiskId              = riskMitigation.RiskId;
            MitigationPlan      = riskMitigation.MitigationPlan;
            Plan                = riskMitigation.Plan;
            Actual              = riskMitigation.Actual;
            Evidence            = riskMitigation.Evidence;
            notes               = riskMitigation.notes;
            ModifiedBy          = riskMitigation.ModifiedBy;
            ModifiedDate        = riskMitigation.ModifiedDate;
            CreatedBy           = riskMitigation.CreatedBy;
            CreatedDate         = riskMitigation.CreatedDate;
            IsDeleted           = riskMitigation.IsDeleted;
            FillMonthOptions();
        }

        public Business.Entities.RiskMitigation GetDbObject()
        {
            Business.Entities.RiskMitigation dbItem = new Business.Entities.RiskMitigation();
            dbItem.MitigationId = MitigationId;
            dbItem.RiskId = RiskId;
            dbItem.MitigationPlan = MitigationPlan;
            dbItem.Plan = Plan;
            dbItem.Actual = Actual;
            dbItem.Evidence = Evidence;
            dbItem.notes = notes;
            dbItem.ModifiedBy = ModifiedBy;
            dbItem.ModifiedDate = ModifiedDate;
            dbItem.CreatedBy = CreatedBy;
            dbItem.CreatedDate = CreatedDate;
            dbItem.IsDeleted = IsDeleted;

            return dbItem;
        }

        public int MitigationId { get; set; }
        public int RiskId { get; set; }
        [AllowHtml]
        [Display(Name = "Rencana Mitigasi")]
        public string MitigationPlan { get; set; }
        [Display(Name = "Rencana Pelaksanaan Risk Treatment")]
        public Nullable<int> Plan { get; set; }
        [Display(Name = "Actual Pelaksanaan Risk Treatment")]
        public Nullable<int> Actual { get; set; }
        [Display(Name = "Bukti (Evidence)")]
        public string Evidence { get; set; }
        [AllowHtml]
        [Display(Name = "Keterangan")]
        public string notes { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<bool> IsDeleted { get; set; }

        public virtual Business.Entities.Risk Risk { get; set; }
        [Display(Name = "Kejadian Risiko")]
        public string RiskEvent { get; set; }
        
        public List<SelectListItem> MonthOptions { get; set; }

        public void FillMonthOptions()
        {
            MonthOptions = new List<SelectListItem>();

            EnumHelper eh = new EnumHelper();
            MonthOptions = Enum.GetValues(typeof(MONTH)).Cast<MONTH>().Select(x => new SelectListItem
            {
                Text = eh.GetEnumDescription((MONTH)Enum.Parse(typeof(MONTH), x.ToString())),
                Value = ((int) x).ToString()
            }).ToList();
        }
    }
}