using Business.Entities;
using Common.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Areas.Risk.Models.RiskImpact
{
    public class RiskImpactFormStub
    {

        public RiskImpactFormStub()
        {
        }
        public RiskImpactFormStub(Business.Entities.RiskImpact riskImpact)
        {

            ImpactId            = riskImpact.ImpactId;
            RiskId              = riskImpact.RiskId;
            Type                = riskImpact.Type;
            QuantitatifImpact   = riskImpact.QuantitatifImpact;
            Probability         = riskImpact.Probability;
            Impact              = riskImpact.Impact;
            RPN                 = riskImpact.RPN;
            ModifiedBy          = riskImpact.ModifiedBy;
            ModifiedDate        = riskImpact.ModifiedDate;
            CreatedBy           = riskImpact.CreatedBy;
            CreatedDate         = riskImpact.CreatedDate;
        }

        public Business.Entities.RiskImpact GetDbObject()
        {
            Business.Entities.RiskImpact dbItem = new Business.Entities.RiskImpact();
            dbItem.ImpactId = ImpactId;
            dbItem.RiskId = RiskId;
            dbItem.Type = Type;
            dbItem.QuantitatifImpact = QuantitatifImpact;
            dbItem.Probability = Probability;
            dbItem.Impact = Impact;
            dbItem.RPN = RPN;
            dbItem.ModifiedBy = ModifiedBy;
            dbItem.ModifiedDate = ModifiedDate;
            dbItem.CreatedBy = CreatedBy;
            dbItem.CreatedDate = CreatedDate;

            return dbItem;
        }

        public int ImpactId { get; set; }
        public int RiskId { get; set; }
        public string Type { get; set; }
        public Nullable<double> QuantitatifImpact { get; set; }
        public Nullable<int> Probability { get; set; }
        public Nullable<int> Impact { get; set; }
        public Nullable<int> RPN { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<bool> IsDeleted { get; set; }

        public virtual Business.Entities.Risk Risk { get; set; }
    }
}