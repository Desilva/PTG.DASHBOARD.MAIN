using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Net;
using Business.Infrastructure;
using Business.Linq;
using Business.Entities;
using Business.Abstract;
namespace Business.Concrete
{
    public class EFUserRepository : IUserRepository
    {
        private PTGMainEntities context = new PTGMainEntities();

        private IQueryable<User> IQUser(List<SortingInfo> sortings = null, FilterInfo filters = null)
        {
            //kamus
            IQueryable<User> list = context.Users;
            FilterInfo copyFilters = null;
            string sort = "";
            List<string> sortArr = new List<string>();
 
            //algoritma
            if (filters != null)
                copyFilters = filters.Clone();

            if (copyFilters != null && (copyFilters.Field != null || copyFilters.Filters != null))
            {
                // copyFilters.FormatFieldToUnderscore();
               
                GridHelper.ProcessFilters<User>(copyFilters, ref list);
            }
  

            if (sortings != null && sortings.Count > 0)
            {
                foreach (var s in sortings)
                {
                    // s.FormatSortOnToUnderscore();
                    sortArr.Add(s.SortOn + " " + s.SortOrder);
                }

                sort = string.Join(",", sortArr);
                list = list.OrderBy<User>(sort);
            }
            else
            {
                list = list.OrderBy<User>("UserId desc"); //default, wajib ada atau EF error
            }

            return list;
        }

        #region car

        public List<User> FindAll(int? skip = null, int? take = null, List<SortingInfo> sortings = null, FilterInfo filters = null)
        {
            IQueryable<User> list = IQUser(sortings, filters);

            //take & skip
            var takeList = list;
            if (skip != null)
            {
                takeList = takeList.Skip(skip.Value);
            }
            if (take != null)
            {
                takeList = takeList.Take(take.Value);
            }

            //return result
            //var sql = takeList.ToString();
            List<User> result = takeList.ToList();
            return result;
        }

        public User Find(List<SortingInfo> sortings = null, FilterInfo filters = null)
        {
            IQueryable<User> list = IQUser(sortings, filters);
            return list.FirstOrDefault();
        }

        public int Count(FilterInfo filters = null)
        {
            IQueryable<User> items = IQUser(null, filters);

            return items.Count();
        }
 
 
        #endregion


 
    }
}
