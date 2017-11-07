using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebUI.Infrastructure
{
    public class AuthenticationHelper
    {
        public static string SessionName
        {
            get
            {
                return "AUTH_SESSION";
            }
        }
    }
}