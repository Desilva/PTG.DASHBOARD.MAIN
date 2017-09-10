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
    }
}