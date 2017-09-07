using System.Web;
using System.Web.Optimization;

namespace WebUI
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            #region StyleBundle

            bundles.Add(new StyleBundle("~/Content/css").Include(
                    "~/Content/bootstrap/css/bootstrap.min.css",
                    "~/Content/animate.css",
                    "~/Content/style.css",
                    "~/Content/document.css"));

            bundles.Add(new StyleBundle("~/Content/popup").Include(
                  "~/Content/popup.css"));

            bundles.Add(new StyleBundle("~/font-awesome/css").Include(
                    "~/Content/inspinia/fonts/font-awesome/css/font-awesome.min.css", new CssRewriteUrlTransform()));

            bundles.Add(new StyleBundle("~/Content/sweetalert").Include(
                    "~/Content/sweet-alert/sweet-alert.css"));

            bundles.Add(new StyleBundle("~/Content/kendo/css").Include(
                    "~/Content/kendo/kendo.common-bootstrap.min.css",
                    "~/Content/kendo/kendo.bootstrap.min.css"));

            #endregion

            #region ScriptBundle
            // JQuery Script Vendor
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                    "~/Scripts/jquery-3.1.1.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jquerymigrate").Include(     
                "~/Scripts/jquery-migrate-3.0.0.min.js"));

            // jQuery Validation
            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                    "~/Scripts/jquery.validate*"));

            // Bootstrap script
            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                    "~/Scripts/bootstrap.min.js"));

            // Inspinia script
            bundles.Add(new ScriptBundle("~/bundles/inspinia").Include(
                    "~/Scripts/Inspinia/app/inspinia.js"));

            // SlimScroll
            bundles.Add(new ScriptBundle("~/plugins/slimScroll").Include(
                    "~/Scripts/Inspinia/plugins/slimScroll/jquery.slimscroll.min.js"));

            // jQuery plugins
            bundles.Add(new ScriptBundle("~/plugins/metsiMenu").Include(
                    "~/Scripts/Inspinia/plugins/metisMenu/metisMenu.min.js"));

            bundles.Add(new ScriptBundle("~/plugins/pace").Include(
                    "~/Scripts/Inspinia/plugins/pace/pace.min.js"));

            // Sweetalert Script
            bundles.Add(new ScriptBundle("~/bundles/sweet-alert").Include(
                    "~/Scripts/sweet-alert/sweet-alert.min.js"));

            // Helper Script
            bundles.Add(new ScriptBundle("~/bundles/webapp").Include(
                    "~/Scripts/webapp.js"));

            // kendo Script
            bundles.Add(new ScriptBundle("~/bundles/kendo").Include(
                "~/Scripts/kendo/kendo.all.min.js",
                "~/Scripts/kendo/cultures/kendo.culture.id-ID.min.js"));

            // modernizr script
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Scripts/modernizr-2.8.3"));


            //page script
            bundles.Add(new ScriptBundle("~/bundles/placcount").Include(
                        "~/Scripts/PTG.FIN/placcount/placcount.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/rkap").Include(
                        "~/Scripts/PTG.FIN/UpdateRKAP/RKAP.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/actual").Include(
                        "~/Scripts/PTG.FIN/UpdateRKAP/actual.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/prognosis").Include(
                        "~/Scripts/PTG.FIN/UpdateRKAP/prognosis.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/balanceSheet").Include(
                        "~/Scripts/PTG.FIN/UpdateRKAP/balanceSheet.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/balanceSheet150").Include(
                        "~/Scripts/PTG.FIN/UpdateRKAP/balanceSheet150.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/companyHealth").Include(
                        "~/Scripts/PTG.FIN/UpdateRKAP/companyHealth.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/dashboard").Include(
                        "~/Scripts/PTG.FIN/dashboard.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/dashboardTable").Include(
                        "~/Scripts/PTG.FIN/dashboardTable.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/companyHealthDashboard").Include(
                        "~/Scripts/PTG.FIN/companyHealthDashboard.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/companyHealthDetail").Include(
                        "~/Scripts/PTG.FIN/companyHealthDetail.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/financeDownload").Include(
                       "~/Scripts/PTG.FIN/Download/financeDownload.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/risk").Include(
                       "~/Scripts/PTG.DASHBOARD.MAIN/risk.js"
            ));

            #endregion

            bundles.IgnoreList.Clear();
            BundleTable.EnableOptimizations = false;
        }
    }
}