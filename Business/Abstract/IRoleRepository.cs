using Business.Entities;
using Business.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Abstract
{
    public interface IRoleRepository
    {
        Role FindByName(string roleName);
        void AddModuleAndAction(string[] modules,string role);

        #region Asynchronous
        Task<Role> FindByNameAsync(string roleName);
        Task<Role> FindByRoleIdAsync(Guid roleId);
        Task AddModuleAndActionAsync(string[] modules, string role);
        Task EditAsync(Role dbItem);
        #endregion
    }
}
