using System.Web.Mvc;

namespace WebUI.Areas.Risk
{
    public class RiskAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Risk";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "Risk_default",
                "Risk/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}