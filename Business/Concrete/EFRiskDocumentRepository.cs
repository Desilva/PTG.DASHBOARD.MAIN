using Business.Abstract;
using Business.Entities;
using Business.Infrastructure;
using Business.Linq;
using Common.Enums;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Concrete
{
    public class EFRiskDocumentRepository : BaseRepository<RiskDocument>, IRiskDocumentRepository
    {

    }
}
