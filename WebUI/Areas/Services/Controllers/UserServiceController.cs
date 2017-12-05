using System.Collections.Generic;
using System.Linq;
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
using System.Web.Http;
using Business.Concrete;

namespace WebUI.Areas.Services.Controllers
{
    public class UserServiceController : ApiController
    {
        private IUserRepository userRepo = new EFUserRepository();
        private IRoleRepository roleRepo = new EFRoleRepository();
        private IMembershipService membershipService;
        private IAuthenticationService authenticationService;

        public UserServiceController()
        {
            membershipService = new MembershipService(System.Web.Security.Membership.Provider);
            authenticationService = new AuthenticationService(membershipService, new FormsAuthenticationService());
        }

        [HttpPost]
        public ServiceStub<UserServiceStub> Login([FromBody] LogOnViewModel model)
        {
            ServiceStub<UserServiceStub> result = new ServiceStub<UserServiceStub>();
            if (ModelState.IsValid)
            {
                string deviceId = model.DeviceId;

                //model.Password = AESEncryptionLibrary.EncryptText(model.Password, "M013i1)!9TpD"); //for debugging only, please comment on production
                ActiveDirectoryUtil AdModel = new ActiveDirectoryUtil();
                AdModel.Login(model.UserName, model.Password, model.RememberMe);
                if (AdModel.IsAuthenticated)
                {
                    Request.Headers.Add("token", MD5EncryptionLibrary.MD5Hash(model.UserName));
                    UserServiceStub user = new UserServiceStub()
                    {
                        username = model.UserName,
                        roles = AdModel.Roles
                    };

                    List<UserServiceStub> users = new List<UserServiceStub>();
                    users.Add(user);

                    result.status = 200;
                    result.message = "Authorized";
                    result.total = users.Count;
                    result.data = users;
                    return result;
                }
                else
                {
                    result.status = 400;
                    result.message = "Username or password is invalid/not registered";
                    result.total = 0;
                    result.data = new List<UserServiceStub>();
                    return result;
                }
            }
            else
            {
                result.status = 400;
                result.message = "Username / password / device id cannot be empty";
                result.total = 0;
                result.data = new List<UserServiceStub>();
                return result;
            }
        }

    }
}
