using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Threading.Tasks;
using Common.Enums;
using Business.Infrastructure;
using Business.Entities;


namespace Business.Abstract
{

    public interface IUserRepository
    {
        List<User> FindAll(int? skip = null, int? take = null, List<SortingInfo> sortings = null, FilterInfo filters = null);
        User Find(List<SortingInfo> sortings = null, FilterInfo filters = null);
       
        int Count(FilterInfo filters = null);
    }
}
