using Business.Entities;
using Business.Abstract;
using Business.Concrete;
using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Mvc;
using System.Web.Security;
using SecurityGuard.Services;
using SecurityGuard.Interfaces;
using SecurityGuard.ViewModels;
using WebUI.Controllers;
using System.Threading.Tasks;
using System.Linq;
using Common.Enums;
using WebUI.Infrastructure;

namespace WebUI.Areas.SecurityGuard.Controllers
{
    [AuthorizeUser(ModuleName = UserModule.SECURITY_GUARD)]
    public partial class RoleController : BaseController
    {

        #region ctors

        private readonly IRoleService roleService;
        private IModuleRepository moduleRepo;
        private IActionRepository actionRepo;
        private IRoleRepository roleRepo;
        private IModulesInRoleRepository repoModulesInRole;

        public RoleController(IModuleRepository repoParam, IActionRepository repoActionParam, IRoleRepository repoRole, IModulesInRoleRepository repoModulesInRole)
        {
            this.roleService = new RoleService(Roles.Provider);
            moduleRepo = repoParam;
            actionRepo = repoActionParam;
            roleRepo = repoRole;
            this.repoModulesInRole = repoModulesInRole;
        }

        #endregion

        public virtual ActionResult Index()
        {
            ManageRolesViewModel model = new ManageRolesViewModel();
            model.Roles = new SelectList(roleService.GetAllRoles());
            model.RoleList = roleService.GetAllRoles();

            return View(model);
        }

        #region Create Roles Methods

        [HttpGet]
        public virtual ActionResult CreateRole()
        {
            return View(new RoleViewModel());
        }

        [HttpPost]
        public virtual ActionResult CreateRole(string roleName)
        {
            JsonResponse response = new JsonResponse();

            if (string.IsNullOrEmpty(roleName))
            {
                response.Success = false;
                response.Message = "You must enter a role name.";
                response.CssClass = "red";

                return Json(response);
            }

            try
            {
                roleService.CreateRole(roleName);

                if (Request.IsAjaxRequest())
                {
                    response.Success = true;
                    response.Message = "Role created successfully!";
                    response.CssClass = "green";

                    return Json(response);
                }

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                if (Request.IsAjaxRequest())
                {
                    response.Success = false;
                    response.Message = ex.Message;
                    response.CssClass = "red";

                    return Json(response);
                }

                ModelState.AddModelError("", ex.Message);
            }

            return RedirectToAction("Index");
        }

        #endregion

        #region add modules to role
        //public ActionResult AddModule(string role)
        //{
        //    AddModulesToRoleViewModel model = new AddModulesToRoleViewModel();
        //    List<Business.Entities.Module> temp = new List<Module>();
        //    string render = "";

        //    model.RoleName = role;
        //    model.Actions = actionRepo.Find(0, null,null,null,null);
        //    var rootModule = (moduleRepo.Find()).FindAll(x => x.ParentModule == null);
        //    Role r = roleRepo.FindByName(role);

        //    foreach (Module m in rootModule)
        //    {
        //        moduleRepo.GetAllChildrenInModule(m.ModuleName, ref temp, 0);
        //    }

        //    foreach (Module m in temp)
        //    {
        //        render += DrawRowModule(m.lvl, m, model.Actions, r);
        //    }
        //    model.Render = render;

        //    return View(model);
        //}

        //[HttpPost]
        //public ActionResult AddModulesToRole(string[] modules, string roleName)
        //{
        //    JsonResponse response = new JsonResponse();
        //    try
        //    {
        //        roleRepo.AddModuleAndAction(modules, roleName);

        //        if (Request.IsAjaxRequest())
        //        {
        //            response.Success = true;
        //            response.Message = "Module added successfully!";
        //            response.CssClass = "green";

        //            return Json(response);
        //        }

        //        return RedirectToAction("AddModule");
        //    }
        //    catch (Exception ex)
        //    {
        //        if (Request.IsAjaxRequest())
        //        {
        //            response.Success = false;
        //            response.Message = ex.Message + "\r\n" + ex.StackTrace + "\r\n" + ex.InnerException.Message + "\r\n" + ex.InnerException.StackTrace;
        //            response.CssClass = "red";

        //            return Json(response);
        //        }

        //        ModelState.AddModelError("", ex.Message);
        //    }

        //    return RedirectToAction("AddModule");
        //}
        #endregion

        #region Private
        private Task<string[]> GetUsersInRoleAsync(string roleName)
        {
            return Task.FromResult(roleService.GetUsersInRole(roleName));
        }
        private Task<string[]> GetAllRolesAsync()
        {
            return Task.FromResult(roleService.GetAllRoles());
        }

        private Task CreateRoleAsync(string roleName)
        {
            return Task.Run(() => roleService.CreateRole(roleName));
        }

        private Task DeleteRoleAsync(string roleName)
        {
            return Task.Run(() => roleService.DeleteRole(roleName));
        }
        #endregion

          #region Edit Roles Methods
        [HttpPost]
        public async Task<Guid> RoleId(string roleName)
        {
            Guid result = (await roleRepo.FindByNameAsync(roleName)).RoleId;
            return result;
        }

        [HttpPost]
        public virtual async Task<ActionResult> EditRole(Guid roleId, string roleName, string tempRoleName)
        {
            JsonResponse response = new JsonResponse();

            if (string.IsNullOrEmpty(roleName))
            {
                response.Success = false;
                response.Message = "You must enter a role name.";
                response.CssClass = "red";

                return Json(response);
            }

            try
            {
                if (roleName.ToLower().Equals(tempRoleName.ToLower()))
                {
                    Role dbItem = await roleRepo.FindByRoleIdAsync(roleId);
                    dbItem.RoleName = roleName;

                    await roleRepo.EditAsync(dbItem);

                    if (Request.IsAjaxRequest())
                    {
                        response.Success = true;
                        response.Message = "Role edited successfully!";
                        response.CssClass = "green";

                        return Json(response);
                    }
                }

                if (!roleService.RoleExists(roleName))
                {
                    Role dbItem = await roleRepo.FindByRoleIdAsync(roleId);
                    dbItem.RoleName = roleName;

                    await roleRepo.EditAsync(dbItem);

                    if (Request.IsAjaxRequest())
                    {
                        response.Success = true;
                        response.Message = "Role edited successfully!";
                        response.CssClass = "green";

                        return Json(response);
                    }
                }
                else
                {
                    if (Request.IsAjaxRequest())
                    {
                        response.Success = false;
                        response.Message = "Role already exists!";
                        response.CssClass = "red";

                        return Json(response);
                    }
                }

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                if (Request.IsAjaxRequest())
                {
                    response.Success = false;
                    response.Message = ex.Message;
                    response.CssClass = "red";

                    return Json(response);
                }

                ModelState.AddModelError("", ex.Message);
            }

            return RedirectToAction("Index");
        }
        #endregion

        #region Delete Roles Methods

        /// <summary>
        /// This is an Ajax method.
        /// </summary>
        /// <param name="roleName"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteRole(string roleName)
        {
            JsonResponse response = new JsonResponse();

            if (string.IsNullOrEmpty(roleName))
            {
                response.Success = false;
                response.Message = "You must select a Role Name to delete.";
                response.CssClass = "red";

                return Json(response);
            }

            roleService.DeleteRole(roleName);

            response.Success = true;
            response.Message = roleName + " was deleted successfully!";
            response.CssClass = "green";

            return Json(response);
        }

        [HttpPost]
        public ActionResult DeleteRoles(string roles, bool throwOnPopulatedRole)
        {
            JsonResponse response = new JsonResponse();
            response.Messages = new List<ResponseItem>();

            if (string.IsNullOrEmpty(roles))
            {
                response.Success = false;
                response.Message = "You must select at least one role.";
                return Json(response);
            }

            string[] roleNames = roles.Split(',');
            StringBuilder sb = new StringBuilder();

            ResponseItem item = null;

            foreach (var role in roleNames)
            {
                if (!string.IsNullOrEmpty(role))
                {
                    try
                    {
                        roleService.DeleteRole(role, throwOnPopulatedRole);

                        item = new ResponseItem();
                        item.Success = true;
                        item.Message = "Deleted this role successfully - " + role;
                        item.CssClass = "green";
                        response.Messages.Add(item);

                        //sb.AppendLine("Deleted this role successfully - " + role + "<br />");
                    }
                    catch (System.Configuration.Provider.ProviderException ex)
                    {
                        //sb.AppendLine(role + " - " + ex.Message + "<br />");

                        item = new ResponseItem();
                        item.Success = false;
                        item.Message = ex.Message;
                        item.CssClass = "yellow";
                        response.Messages.Add(item);
                    }
                }
            }

            response.Success = true;
            response.Message = sb.ToString();

            return Json(response);
        }

        #endregion

        #region Get Users In Role methods

        /// <summary>
        /// This is an Ajax method that populates the 
        /// Roles drop down list.
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllRoles()
        {
            var list = roleService.GetAllRoles();

            List<SelectObject> selectList = new List<SelectObject>();

            foreach (var item in list)
            {
                selectList.Add(new SelectObject() { caption = item, value = item });
            }

            return Json(selectList, JsonRequestBehavior.AllowGet);
        }

        public async Task<ActionResult> GetListRoles()
        {
            var list = await GetAllRolesAsync();

            List<SelectObject> selectList = new List<SelectObject>();

            selectList.Add(new SelectObject() { caption = "[Select Role]", value = "" });
            foreach (var item in list)
            {
                selectList.Add(new SelectObject() { caption = item, value = item });
            }

            return Json(selectList, JsonRequestBehavior.AllowGet);
        }



        [HttpGet]
        public ActionResult GetUsersInRole(string roleName)
        {
            var list = roleService.GetUsersInRole(roleName);

            return Json(list, JsonRequestBehavior.AllowGet);
        }


        #endregion

        #region add Modules to Role

        /// <summary>
        /// Return two lists:
        ///   1)  a list of Actions not in module
        ///   2)  a list of Actions in module
        /// </summary>
        /// <param name="moduleName"></param>
        /// <returns></returns>
        /// 
        //[MvcSiteMapNode(Title = "Add Action to Modules", ParentKey = "ManageModules", Key = "AddActiontoModules")]
        //[SiteMapTitle("Breadcrumb")]
        [HttpGet]
        public virtual ActionResult AddModule(string roleName)
        {
            if (string.IsNullOrEmpty(roleName))
            {
                return RedirectToAction("Index");
            }

            GrantModulesToRoleViewModel model = new GrantModulesToRoleViewModel();
            model.RoleName = roleName;
            model.GUID = roleRepo.FindByName(roleName).RoleId.ToString();
            string actionId = actionRepo.Find().Select(m => m.Id).FirstOrDefault().ToString();

            List<Business.Entities.Module> availableMOdules = moduleRepo.Find();
            List<Business.Entities.Module> usedModules = roleRepo.FindByName(roleName).ModulesInRoles.Select(m => m.Module).ToList();

            //used action
            foreach (Business.Entities.Module a in usedModules)
            {
                availableMOdules.RemoveAll(x => x.ModuleName == a.ModuleName);
            }

            List<ModuleStub> availableMOduleStub = new ModuleStub().MapList(availableMOdules, actionId);
            List<ModuleStub> usedModuleStub = new ModuleStub().MapList(usedModules, actionId);
            model.AvailableModules = new SelectList(availableMOduleStub, "Id", "ModuleName");
            model.GrantedModules = new SelectList(usedModuleStub, "Id", "ModuleName");

            return View(model);
        }

        public virtual ActionResult GrantModulesToRole(string RoleId, string Modules)
        {
            JsonResponse response = new JsonResponse();
            response.Messages = new List<ResponseItem>();

            string[] moduleIds = Modules.Split(',');
            StringBuilder sb = new StringBuilder();

            ResponseItem item = null;            
                                
            try
            {
                roleRepo.AddModuleAndAction(moduleIds, RoleId);

                item = new ResponseItem();
                item.Success = true;
                response.Message ="modules was added successfully!";
                response.CssClass = "green";
                response.Messages.Add(item);
            }
            catch (Exception ex)
            {
                item = new ResponseItem();
                item.Success = false;
                response.Success = false;
                response.Message = ex.Message;
                response.CssClass = "red";
                response.Messages.Add(item);
            }                            
            return Json(response);
        }

        public virtual ActionResult ViewRoleModule()
        {
            ViewBag.modules = moduleRepo.Find();
            ViewBag.actions = actionRepo.Find();
            return PartialView();
        }

        public virtual ActionResult RevokeModulesForRole(string RoleId, string Modules)
        {
            //JsonResponse response = new JsonResponse();
            //response.Messages = new List<ResponseItem>();

            //string[] moduleIds = Modules.Split(',');
            //StringBuilder sb = new StringBuilder();

            //ResponseItem item = null;

            //foreach (string s in moduleIds)
            //{
            //    if (!string.IsNullOrWhiteSpace(s))
            //    {
            //        try
            //        {
            //            //remove action in repo
            //            repoModulesInRole.DeleteByModule(new Guid(s));                        

            //            ////remove action in ModulesInRole
            //            //modulesInRoleRepo.RemoveAction(new Guid(moduleId), new Guid(s));

            //            ////remove all empty actions in ModulesInRole
            //            //modulesInRoleRepo.DeleteByModule(new Guid(moduleId));

            //            item = new ResponseItem();
            //            item.Success = true;
            //            response.Message = moduleRepo.FindByPk(new Guid(s)).ModuleName + " was removed successfully!";
            //            response.CssClass = "green";
            //            response.Messages.Add(item);
            //        }
            //        catch (Exception ex)
            //        {
            //            item = new ResponseItem();
            //            item.Success = false;
            //            response.Success = false;
            //            response.Message = ex.Message;
            //            response.CssClass = "red";
            //            response.Messages.Add(item);
            //        }
            //    }
            //}

            //return Json(response);
            JsonResponse response = new JsonResponse();
            response.Messages = new List<ResponseItem>();

            string[] moduleIds = Modules.Split(',');
            StringBuilder sb = new StringBuilder();

            ResponseItem item = null;

            try
            {
                roleRepo.AddModuleAndAction(moduleIds, RoleId);

                item = new ResponseItem();
                item.Success = true;
                response.Message = "modules was added successfully!";
                response.CssClass = "green";
                response.Messages.Add(item);
            }
            catch (Exception ex)
            {
                item = new ResponseItem();
                item.Success = false;
                if (moduleIds == null)
                {
                    item = new ResponseItem();
                    item.Success = true;
                    response.Message = "modules was added successfully!";
                    response.CssClass = "green";
                    response.Messages.Add(item);
                }
                else
                {
                    response.Success = false;
                    response.Message = ex.Message;
                    response.CssClass = "red";
                    response.Messages.Add(item);
                }
               
            }
            return Json(response);
        }      
        #endregion
        


        #region Helper
        public string DrawRowModule(int level, Module m, List<Business.Entities.Action> actions, Role role)
        {
            string collumn = "col-md-" + 9 / (actions.Count + 1);
            string style = "margin-left:" + 15 * level + "px";
            string row = @"<div class='row' style='margin-bottom: 0; border-bottom:1px solid #000'>
                            <div class='col-md-4'><div style='" + style + "'>" + m.ModuleName + @"</div></div>";

            foreach (Business.Entities.Action a in actions)
            {
                bool found = false;
                var enumerator = m.Actions.GetEnumerator();
                while (enumerator.MoveNext() && !found)
                {
                    if (enumerator.Current.Id == a.Id)
                    {
                        found = true;
                    }
                }

                if (found)
                {
                    ModulesInRole mr = repoModulesInRole.FindByRoleAndModule(role.RoleId, m.Id);
                    found = false;
                    if (mr != null)//check action
                    {
                        enumerator = mr.Actions.GetEnumerator();
                        while (enumerator.MoveNext() && !found)
                        {
                            if (enumerator.Current.Id == a.Id)
                            {
                                found = true;
                            }
                        }
                    }
                    if (found)
                        row += "<div class='" + collumn + @"' style='text-align:center;'><input type='checkbox' checked='checked' value='" + m.Id + ";" + a.Id + "' /></div>";
                    else
                        row += "<div class='" + collumn + @"' style='text-align:center;'><input type='checkbox' value='" + m.Id + ";" + a.Id + "' /></div>";
                }
                else
                {
                    row += "<div class='" + collumn + @"' style='text-align:center;'>-</div>";
                }
            }

            row += " </div>";

            return row;
        }
        #endregion

    }
}