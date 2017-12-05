using Business.Entities;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Security;

namespace SecurityGuard.ViewModels
{
    public class GrantModulesToRoleViewModel
    {
        //public MembershipUser User { get; set; }
        public string GUID { get; set; }
        public string RoleName { get; set; }
        public SelectList AvailableModules { get; set; }
        public SelectList GrantedModules { get; set; }
    }

    public class ModuleStub
    {
        public string Id { get; set; }
        public string ModuleName { get; set; }
        public ModuleStub() { }
        public ModuleStub(Module dbitem, string actionId )
        {
            Id = dbitem.Id.ToString() + ";" + actionId;
            ModuleName = dbitem.ModuleName;
        }
        public List<ModuleStub> MapList(List<Module>dbList, string actionId)
        {
            List<ModuleStub> result = new List<ModuleStub>();
            foreach(Module item in dbList)
            {
                ModuleStub model = new ModuleStub(item, actionId);
                result.Add(model);
            }
            return result;
        }
    }
}
