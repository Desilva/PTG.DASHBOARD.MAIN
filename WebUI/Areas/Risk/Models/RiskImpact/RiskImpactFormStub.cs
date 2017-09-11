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
        const int MAX_PROBABILITAS = 5;
        const int MAX_DAMPAK = 5;

        public RiskImpactFormStub()
        {
            FillProbabilityOptions();
            FillImpactOptions();
            IsDeleted = false;
        }
        public RiskImpactFormStub(Business.Entities.RiskImpact riskImpact)
        {
            RiskId                  = riskImpact.RiskId;
            ImpactId                = riskImpact.ImpactId;
            QuantitatifImpact       = riskImpact.QuantitatifImpact;
            Probability             = riskImpact.Probability;
            Impact                  = riskImpact.Impact;
            RPN                     = riskImpact.RPN;
            QuantitatifImpactRes    = riskImpact.QuantitatifImpactRes;
            ProbabilityRes          = riskImpact.ProbabilityRes;
            ImpactRes               = riskImpact.ImpactRes;
            RPNRes                  = riskImpact.RPNRes;
            ModifiedBy              = riskImpact.ModifiedBy;
            ModifiedDate            = riskImpact.ModifiedDate;
            CreatedBy               = riskImpact.CreatedBy;
            CreatedDate             = riskImpact.CreatedDate;
            IsDeleted               = riskImpact.IsDeleted;

            FillProbabilityOptions();
            FillImpactOptions();
        }

        public Business.Entities.RiskImpact GetDbObject()
        {
            Business.Entities.RiskImpact dbItem = new Business.Entities.RiskImpact();
            dbItem.Type = "";
            dbItem.ImpactId = ImpactId;
            dbItem.RiskId = RiskId;
            dbItem.QuantitatifImpact = QuantitatifImpact;
            dbItem.Probability = Probability;
            dbItem.Impact = Impact;
            dbItem.RPN = RPN;
            dbItem.QuantitatifImpactRes = QuantitatifImpactRes;
            dbItem.ProbabilityRes = ProbabilityRes;
            dbItem.ImpactRes = ImpactRes;
            dbItem.RPNRes = RPNRes;
            dbItem.ModifiedBy = ModifiedBy;
            dbItem.ModifiedDate = ModifiedDate;
            dbItem.CreatedBy = CreatedBy;
            dbItem.CreatedDate = CreatedDate;
            dbItem.IsDeleted = IsDeleted;

            return dbItem;
        }
        
        public int ImpactId { get; set; }
        public int RiskId { get; set; }
        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "Dampak Kuantitatif (Ribu USD)")]
        public Nullable<double> QuantitatifImpact { get; set; }
        [Display(Name = "Probabilitas")]
        public Nullable<int> Probability { get; set; }
        [Display(Name = "Dampak")]
        public Nullable<int> Impact { get; set; }
        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "RPN")]
        public Nullable<int> RPN { get; set; }
        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "Dampak Kuantitatif (Ribu USD)")]
        public Nullable<double> QuantitatifImpactRes { get; set; }
        [Display(Name = "Probabilitas")]
        public Nullable<int> ProbabilityRes { get; set; }
        [Display(Name = "Dampak")]
        public Nullable<int> ImpactRes { get; set; }
        [Required(ErrorMessageResourceName = "Required", ErrorMessageResourceType = typeof(Resources.MyGlobalErrors))]
        [Display(Name = "RPN")]
        public Nullable<int> RPNRes { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<bool> IsDeleted { get; set; }

        public virtual Business.Entities.Risk Risk { get; set; }

        public List<SelectListItem> ProbabilityOptions { get; set; }
        public List<SelectListItem> ImpactOptions { get; set; }
        [Display(Name = "Kejadian Risiko")]
        public string RiskEvent { get; set; }


        public void FillProbabilityOptions()
        {
            ProbabilityOptions = new List<SelectListItem>();
            for(int it = 1; it <= MAX_PROBABILITAS; it++)
            {
                ProbabilityOptions.Add(new SelectListItem(){
                    Text = it.ToString(),
                    Value = it.ToString()
                });
            }
        }
        public void FillImpactOptions()
        {
            ImpactOptions = new List<SelectListItem>();
            for (int it = 1; it <= MAX_DAMPAK; it++)
            {
                ImpactOptions.Add(new SelectListItem()
                {
                    Text = it.ToString(),
                    Value = it.ToString()
                });
            }
        }
    }
}