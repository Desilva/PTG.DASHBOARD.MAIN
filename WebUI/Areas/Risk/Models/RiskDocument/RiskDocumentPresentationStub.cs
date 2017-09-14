using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Areas.Risk.Models.RiskDocument
{
    public class RiskDocumentPresentationStub
    {
        public RiskDocumentPresentationStub()
        {
            DocumentId = 0;
            IsDeleted = false;
        }
        public RiskDocumentPresentationStub(Business.Entities.RiskDocument riskDocument)
        {
            DocumentId = riskDocument.DocumentId;
            Notes = riskDocument.Notes;
            FilePath = riskDocument.FilePath;
            ModifiedBy = riskDocument.ModifiedBy;
            ModifiedDate = riskDocument.ModifiedDate;
            CreatedBy = riskDocument.CreatedBy;
            CreatedDate = riskDocument.CreatedDate;
            IsDeleted = riskDocument.IsDeleted;
        }

        public int DocumentId { get; set; }
        [Display(Name = "Dokumen")]
        public string FilePath { get; set; }
        [AllowHtml]
        [Display(Name = "Keterangan")]
        public string Notes { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
    }
}