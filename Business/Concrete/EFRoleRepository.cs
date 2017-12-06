using Business.Abstract;
using Business.Entities;
using Business.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Linq;
using System.Text.RegularExpressions;
using System.Data.Entity;

namespace Business.Concrete
{
    public class EFRoleRepository : IRoleRepository
    {
        private PTGMainEntities context = new PTGMainEntities();

        public void AddModuleAndAction(string[] modules, string role)
        {
            Role r = context.Roles.Where(x => x.RoleName == role).FirstOrDefault();
            IEnumerable<ModulesInRole> listModule = r.ModulesInRoles;

            foreach (ModulesInRole mInRole in listModule)
            {
                if (mInRole.Actions.Count > 0)
                {
                    var actions = mInRole.Actions.ToList();
                    foreach (var a in actions)
                    {
                        mInRole.Actions.Remove(a);
                    }
                }
            }

            context.ModulesInRoles.RemoveRange(listModule);
            context.SaveChanges();

            foreach (string s in modules)
            {
                string[] temp = s.Split(';');
                ModulesInRole mr;
                Guid moduleId = new Guid(temp.First());
                Guid actionId = new Guid(temp.Last());

                ModulesInRole available = context.ModulesInRoles.Where(x => x.RoleId == r.RoleId).Where(x => x.ModuleId == moduleId).FirstOrDefault();
                Business.Entities.Action a = context.Actions.Find(actionId);

                if (available != null)
                {
                    if (!available.Actions.Contains(a))
                    {
                        available.Actions.Add(a);
                        context.SaveChanges();
                    }
                }
                else
                {
                    mr = new ModulesInRole()
                    {
                        Id = Guid.NewGuid(),
                        RoleId = r.RoleId,
                        ModuleId = new Guid(temp.First())
                    };
                    mr.Actions.Add(a);
                    r.ModulesInRoles.Add(mr);
                    context.SaveChanges();
                }
            }
        }

        public Role FindByName(string roleName) {
            return context.Roles.Where(x => x.RoleName == roleName).FirstOrDefault();
        }

        #region Asynchronous
        public async Task AddModuleAndActionAsync(string[] modules, string role)
        {
            Role r = await context.Roles.Where(x => x.RoleName == role).FirstOrDefaultAsync();
            IEnumerable<ModulesInRole> listModule = r.ModulesInRoles;
            foreach (ModulesInRole mInRole in listModule)
            {

                if (mInRole.Actions.Count > 0)
                {
                    var actions = mInRole.Actions.ToList();
                    foreach (var a in actions)
                    {
                        mInRole.Actions.Remove(a);
                    }
                }
            }
            context.ModulesInRoles.RemoveRange(listModule);
            await context.SaveChangesAsync().ConfigureAwait(false);

            foreach (string s in modules)
            {
                string[] temp = s.Split(';');
                ModulesInRole mr;
                Guid moduleId = new Guid(temp.First());
                Guid actionId = new Guid(temp.Last());

                ModulesInRole available = await context.ModulesInRoles.Where(x => x.RoleId == r.RoleId).Where(x => x.ModuleId == moduleId).FirstOrDefaultAsync().ConfigureAwait(false);
                Business.Entities.Action a = await context.Actions.FindAsync(actionId).ConfigureAwait(false);

                if (available != null)
                {
                    if (!available.Actions.Contains(a))
                    {
                        available.Actions.Add(a);
                        await context.SaveChangesAsync();
                    }
                }
                else
                {
                    mr = new ModulesInRole()
                    {
                        Id = Guid.NewGuid(),
                        RoleId = r.RoleId,
                        ModuleId = new Guid(temp.First())
                    };
                    mr.Actions.Add(a);
                    r.ModulesInRoles.Add(mr);
                    await context.SaveChangesAsync();
                }
            }

        }

        public async Task<Role> FindByNameAsync(string roleName)
        {
            return await context.Roles.Where(x => x.RoleName == roleName).FirstOrDefaultAsync().ConfigureAwait(false);
        }

        public async Task<Role> FindByRoleIdAsync(Guid roleId)
        {
            return await context.Roles.Where(x => x.RoleId == roleId).FirstOrDefaultAsync().ConfigureAwait(false);
        }
        public async Task EditAsync(Role dbItem)
        {
            context.Entry(dbItem).State = System.Data.Entity.EntityState.Modified;
            await context.SaveChangesAsync().ConfigureAwait(false);
        }
        #endregion



        //public void AddModuleAndActionChoosen(string[] modules, string role, string action)
        //{
        //    Role r = context.Roles.Where(x => x.RoleName == role).FirstOrDefault();
        //    IEnumerable<ModulesInRole> listModule = r.ModulesInRoles;

        //    foreach (ModulesInRole mInRole in listModule)
        //    {
        //        if (mInRole.Actions.Count > 0)
        //        {
        //            var actions = mInRole.Actions.ToList();
        //            foreach (var a in actions)
        //            {
        //                mInRole.Actions.Remove(a);
        //            }
        //        }
        //    }

        //    context.ModulesInRoles.RemoveRange(listModule);
        //    context.SaveChanges();

        //    foreach (string s in modules)
        //    {
        //        string[] temp = s.Split(';');
        //        ModulesInRole mr;
        //        Business.Entities.action
        //        Guid moduleId = new Guid(temp.First());
        //        Guid actionId = new Guid(temp.Last());

        //        ModulesInRole available = context.ModulesInRoles.Where(x => x.RoleId == r.RoleId).Where(x => x.ModuleId == moduleId).FirstOrDefault();
        //        Business.Entities.Action a = context.Actions.Find(actionId);

        //        if (available != null)
        //        {
        //            if (!available.Actions.Contains(a))
        //            {
        //                available.Actions.Add(a);
        //                context.SaveChanges();
        //            }
        //        }
        //        else
        //        {
        //            mr = new ModulesInRole()
        //            {
        //                Id = Guid.NewGuid(),
        //                RoleId = r.RoleId,
        //                ModuleId = new Guid(temp.First())
        //            };
        //            mr.Actions.Add(a);
        //            r.ModulesInRoles.Add(mr);
        //            context.SaveChanges();

        //            action
        //        }
        //    }
        //}


    }
}
