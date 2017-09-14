using Business;
using Business.Abstract;
using Business.Concrete;
using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebUI.Infrastructure.Abstract;
using WebUI.Infrastructure.Concrete;

namespace WebUI.Infrastructure
{
    public class NinjectDependencyResolver : System.Web.Mvc.IDependencyResolver
    {
        private IKernel kernel;

        public NinjectDependencyResolver()
        {
            kernel = new StandardKernel();
            AddBindings();
        }

        public object GetService(Type serviceType)
        {
            return kernel.TryGet(serviceType);
        }

        public IEnumerable<object> GetServices(Type serviceType)
        {
            return kernel.GetAll(serviceType);
        }

        private void AddBindings()
        {
            //user management
            kernel.Bind<IActionRepository>().To<EFActionRepository>();
            kernel.Bind<IModuleRepository>().To<EFModuleRepository>();
            kernel.Bind<IRoleRepository>().To<EFRoleRepository>();
            kernel.Bind<IModulesInRoleRepository>().To<EFModulesInRoleRepository>();

            //others
            kernel.Bind<ILogRepository>().To<EFLogRepository>();
            kernel.Bind<IAuthProvider>().To<DummyAuthProvider>();
            kernel.Bind<IUserRepository>().To<EFUserRepository>();
            kernel.Bind<IRiskRepository>().To<EFRiskRepository>();
            kernel.Bind<IRiskImpactRepository>().To<EFRiskImpactRepository>();
            kernel.Bind<IRiskMitigationRepository>().To<EFRiskMitigationRepository>();
            kernel.Bind<IRiskDocumentRepository>().To<EFRiskDocumentRepository>();

        }
    }
}
