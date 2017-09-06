using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Business.Abstract;
using Business.Entities;
using WebUI.Areas.Services.Models;
using WebUI.Controllers;
using WebUI.Infrastructure;
using SecurityGuard.Interfaces;
using SecurityGuard.Services;
using SecurityGuard.ViewModels;
using System.Threading.Tasks;
using System.Configuration;
using System;
using System.DirectoryServices;

namespace WebUI.Areas.Services.Controllers
{
    public class UserServiceController : BaseController
    {
        private IUserRepository userRepo;
        private IRoleRepository roleRepo;
        private IMembershipService membershipService;
        private IAuthenticationService authenticationService;

        public UserServiceController(IUserRepository repoParam, IRoleRepository roleRepo)
        {
            userRepo = repoParam;
            this.roleRepo = roleRepo;

            membershipService = new MembershipService(System.Web.Security.Membership.Provider);
            authenticationService = new AuthenticationService(membershipService, new FormsAuthenticationService());
        }

        public JsonResult Login(LogOnViewModel model)
        {
            if (ModelState.IsValid)
            {
                string deviceId = model.DeviceId;
#if (DEBUG)
                model.Password = AESEncryptionLibrary.EncryptText(model.Password, "M013i1)!9TpD"); //for debugging only, please comment on production
#endif       
                ActiveDirectoryUtil AdModel = new ActiveDirectoryUtil();
                AdModel.Login(model.UserName, model.Password, model.RememberMe);
                if (AdModel.IsAuthenticated)
                {
                    return Json(new { status = 200, message = "Authorized", username = model.UserName, roles = AdModel.Roles }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { status = 400, message = "Username or password is invalid/not registered" }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {
                return Json(new { status = 500, message = "Username / password / device id cannot be empty" }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetRoles(LogOnViewModel model)
        {
            if(ModelState.IsValid)
            {
#if (DEBUG)
                model.Password = AESEncryptionLibrary.EncryptText(model.Password, "M013i1)!9TpD"); //for debugging only, please comment on production
#endif
                ActiveDirectoryUtil AdModel = new ActiveDirectoryUtil();
                AdModel.Login(model.UserName, model.Password, false);
                if (AdModel.IsAuthenticated)
                {
                    return Json(new { roles = AdModel.Roles }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { status = 400, message = "Username or password is invalid/not registered" }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {
                return Json(new { status = 500, message = "Username / password / device id cannot be empty" }, JsonRequestBehavior.AllowGet);
            }


        }

        //public async Task<JsonResult> GetUserLogin(string username)
        //{
        //    if (User.Identity.IsAuthenticated || (username != null && username.Length > 0))
        //    {
        //        username = User.Identity.IsAuthenticated ? User.Identity.Name : username;
        //        var u = await userRepo.FindByUsernameAsync(username);
        //        var roleIndex = u.Roles.GetEnumerator();
        //        var employee = u.Pegawai.FirstOrDefault();
        //        List<ModuleAction> access = new List<ModuleAction>();
        //        while (roleIndex.MoveNext())
        //        {
        //            Role role = roleIndex.Current;
        //            var listModules = role.ModulesInRoles;
        //            var moduleInRoleIndex = listModules.GetEnumerator();
        //            while (moduleInRoleIndex.MoveNext())
        //            {
        //                ModulesInRole moduleInRole = moduleInRoleIndex.Current;
        //                string moduleName = moduleInRole.Module.ModuleName;
        //                access.AddRange(moduleInRole.Actions.Select(p => new ModuleAction { ModuleName = moduleName, ActionName = p.ActionName }));
        //            }
        //        }
        //        UserServiceModel model = new UserServiceModel
        //        {
        //            id = u.UserId,
        //            username = u.UserName,
        //            rolename = u.Roles.Select(p => p.RoleName).ToList(),
        //            moduleAccess = access,
        //            employeeName = employee != null ? employee.NamaLengkap : u.UserName
        //        };

        //        return Json(model, JsonRequestBehavior.AllowGet);
        //    }

        //    return Json(false, JsonRequestBehavior.AllowGet);
        //}

        //public async Task<JsonResult> GetAllUsers(string[] rolename, int skip = 0, int? take = null)
        //{
        //    List<UserServiceModel> result = new List<UserServiceModel>();
        //    var userList = await userRepo.FindAsync(rolename, skip, take);
        //    foreach (Users u in userList)
        //    {
        //        var employee = u.Pegawai.FirstOrDefault();
        //        UserServiceModel model = new UserServiceModel
        //        {
        //            id = u.UserId,
        //            username = u.UserName,
        //            email = u.Memberships.Email,
        //            employeeName = employee != null ? employee.NamaLengkap : u.UserName
        //        };
        //        result.Add(model);
        //    }

        //    return Json(result, JsonRequestBehavior.AllowGet);
        //}

        //public async Task<JsonResult> GetUsersInModule(string modulename, string actionName = null)
        //{
        //    List<UserServiceModel> result = new List<UserServiceModel>();
        //    var userList = await userRepo.FindAsync(modulename, actionName);
        //    foreach (Users u in userList)
        //    {
        //        var employee = u.Pegawai.FirstOrDefault();
        //        UserServiceModel model = new UserServiceModel
        //        {
        //            id = u.UserId,
        //            username = u.UserName,
        //            email = u.Memberships.Email,
        //            employeeName = employee != null ? employee.NamaLengkap : u.UserName
        //        };
        //        result.Add(model);
        //    }

        //    return Json(result, JsonRequestBehavior.AllowGet);
        //}

    }
}
