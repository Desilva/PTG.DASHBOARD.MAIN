using Business.Concrete;
using Business.Infrastructure;
using System.Collections.Generic;
using System.Linq;

namespace WebUI.Infrastructure
{
    public class ModuleAction
    {
        public string ModuleName { get; set; }
        public string ActionName { get; set; }

        public static List<ModuleAction> GetModuleActionForUser(string username)
        {
            var repoUser = new EFUserRepository();
            var result = new List<ModuleAction>();
            var filter = GetFilterInfo(username);
            var user = repoUser.Find(null, filter);
            var roleIndex = user.Roles.GetEnumerator();
            
            while (roleIndex.MoveNext())
            {
                var role = roleIndex.Current;
                var modulesInRoles = role.ModulesInRoles;
                var moduleInRoleIndex = modulesInRoles.GetEnumerator();

                while (moduleInRoleIndex.MoveNext())
                {
                    var modulesInRole = moduleInRoleIndex.Current;
                    var moduleName = modulesInRole.Module.ModuleName;

                    result.AddRange(modulesInRole.Actions.Select(p => new ModuleAction
                    {
                        ModuleName = moduleName,
                        ActionName = p.ActionName
                    }));
                }
            }

            return result;
        }

        private static FilterInfo GetFilterInfo(string username)
        {
            return new FilterInfo
            {
                Logic = "and",
                Filters = new List<FilterInfo>
                {
                    new FilterInfo
                    {
                        Field = "UserName",
                        Operator = "eq",
                        Value = username
                    }
                }
            };
        }
    }
}