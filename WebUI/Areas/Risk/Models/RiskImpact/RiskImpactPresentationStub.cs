using System;

namespace WebUI.Areas.Risk.Models.RiskImpact
{
    public class RiskImpactPresentationStub
    {

        public RiskImpactPresentationStub()
        {
            IsDeleted = false;
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

        public RiskImpactPresentationStub(Business.Entities.RiskImpact riskImpact)
        {
            RiskId = riskImpact.RiskId;
            ImpactId = riskImpact.ImpactId;
            this.Type = riskImpact.Type;
            QuantitatifImpact = riskImpact.QuantitatifImpact;
            Probability = riskImpact.Probability;
            Impact = riskImpact.Impact;
            RPN = riskImpact.RPN;
            ModifiedBy = riskImpact.ModifiedBy;
            ModifiedDate = riskImpact.ModifiedDate;
            CreatedBy = riskImpact.CreatedBy;
            CreatedDate = riskImpact.CreatedDate;
            IsDeleted = riskImpact.IsDeleted;
        }
        
    }
}