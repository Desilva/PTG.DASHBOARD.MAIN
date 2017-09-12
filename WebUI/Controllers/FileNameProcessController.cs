using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using WebUI.Infrastructure;

namespace WebUI.Controllers
{
    public class FileNameProcessController : Controller
    {
        private const string FILE_DIRECTORY = "~/Uploads/";

        public FileNameProcessController() { }

        public string FriendlyName(string filePath)
        {
            string result = "";

            int indexOfUnderscore = filePath.IndexOf('_');
            if ((indexOfUnderscore >= 0) && (indexOfUnderscore < filePath.Length - 1))
            {
                result = filePath.Substring(indexOfUnderscore + 1);
                result = result.Replace('-', ' ');
                result = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(result);
                string extension = result.Substring(result.LastIndexOf('.'));
                result = result.Replace(extension, extension.ToLower());
            }

            return result;
        }

        public string AbsolutePath(string filePath)
        {
            string result = "";

            if (filePath.Length > 2)
            {
                if (filePath.Substring(0, 2) == "~/")
                {
                    result = "/" + filePath.Substring(2);
                }
            }

            return result;
        }
    }
}
