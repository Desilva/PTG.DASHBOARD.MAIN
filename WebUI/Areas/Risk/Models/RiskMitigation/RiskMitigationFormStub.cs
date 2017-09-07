using Business.Entities;
using Common.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Areas.Risk.Models.RiskMitigation
{
    public class RiskMitigationFormStub
    {

        public RiskMitigationFormStub()
        {
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

            return dbItem;
        }

        public int MitigationId { get; set; }
        public int RiskId { get; set; }
        [Display(Name = "Rencana Mitigasi")]
        public string MitigationPlan { get; set; }
        [Display(Name = "Rencana Pelaksanaan Risk Treatment")]
        public Nullable<int> Plan { get; set; }
        public Nullable<int> Actual { get; set; }
        public string Evidence { get; set; }
        public string notes { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<bool> IsDeleted { get; set; }

        public virtual Business.Entities.Risk Risk { get; set; }
        [Display(Name = "Kejadian Risiko")]
        public string RiskEvent { get; set; }
    }
}