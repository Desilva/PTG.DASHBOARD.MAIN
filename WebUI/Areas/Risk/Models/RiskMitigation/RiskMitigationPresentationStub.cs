using System;
using System.ComponentModel.DataAnnotations;

namespace WebUI.Areas.Risk.Models.RiskMitigation
{
    public class RiskMitigationPresentationStub
    {

        public RiskMitigationPresentationStub()
        {

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
    }
}