using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace WebUI.Areas.Risk.Models.RiskDocument
{
    public class RiskDocumentFormStub
    {
        public RiskDocumentFormStub()
        {
            DocumentId = 0;
            IsDeleted = false;
        }
        public RiskDocumentFormStub(Business.Entities.RiskDocument riskDocument)
        {
            DocumentId                   = riskDocument.DocumentId;
            Notes                        = riskDocument.Notes;
            FilePath                     = riskDocument.FilePath;
            ModifiedBy                   = riskDocument.ModifiedBy;
            ModifiedDate                 = riskDocument.ModifiedDate;
            CreatedBy                    = riskDocument.CreatedBy;
            CreatedDate                  = riskDocument.CreatedDate;
            IsDeleted                    = riskDocument.IsDeleted;
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
        
        public Business.Entities.RiskDocument GetDbObject()
        {
            Business.Entities.RiskDocument dbItem = new Business.Entities.RiskDocument();
            dbItem.DocumentId = DocumentId;
            dbItem.Notes = Notes;   
            dbItem.FilePath = FilePath;
            dbItem.ModifiedBy = ModifiedBy;
            dbItem.ModifiedDate = ModifiedDate;
            dbItem.CreatedBy = CreatedBy;
            dbItem.CreatedDate = CreatedDate;
            dbItem.IsDeleted = IsDeleted;

            return dbItem;
        }
    }
}