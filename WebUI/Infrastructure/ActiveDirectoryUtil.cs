using System;
using System.Collections.Generic;
using System.Configuration;
using System.DirectoryServices;
using System.Linq;
using System.Web;

namespace WebUI.Infrastructure
{
    public class ActiveDirectoryUtil
    {
        public bool IsAuthenticated { get; set; }
        public string Username { get; set; }
        public List<string> Roles { get; set; }

        public string Email { get; set; }

        public ActiveDirectoryUtil()
        {
            Roles = new List<string>();
        }

        public void Login(string username, string password, bool rememberMe)
        {
            this.IsAuthenticated = false;
            //password = AESEncryptionLibrary.DecryptText(password, "M013i1)!9TpD");

            string domain = ConfigurationManager.AppSettings["LDAPHost"].ToString();
            //string loginName = ConfigurationManager.AppSettings["ServerLogin"].ToString();
            //string pass = ConfigurationManager.AppSettings["ServerPassword"].ToString();
            
            DirectoryEntry entry = new DirectoryEntry(domain, username, password);
            try
            {
                DirectorySearcher search = new DirectorySearcher(entry);
                search.Filter = "(sAMAccountName=" + username + ")";

                //Select property in the server to identify roles
                search.PropertiesToLoad.Add("cn");
                search.PropertiesToLoad.Add("mail");

                SearchResult result = search.FindOne();

                if (result != null)
                {
                    Roles.Add((string)result.Properties["cn"][0]);
                    if (result.Properties["mail"] != null && result.Properties["mail"].Count > 0)
                        Email = (string)result.Properties["mail"][0];
                    else
                        Email = "-";
                    this.IsAuthenticated = true;
                }

            }
            catch (Exception ex)
            {
                this.IsAuthenticated = false;
            }

        }
    }
}