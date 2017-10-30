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

            DirectoryEntry entry = new DirectoryEntry("LDAP://10.11.3.90/DC=pertamina,DC=com", username, password, AuthenticationTypes.Secure);

            //DirectoryEntry entry = new DirectoryEntry(domain, username, password);
            try
            {
                DirectorySearcher search = new DirectorySearcher(entry);
                string filter = string.Format("(&(ObjectClass={0})(sAMAccountName={1}))", "person", username);
                string[] properties = new string[] { "fullname", "cn", "mail" };
                //search.Filter = "(sAMAccountName=" + username + ")";

                //Select property in the server to identify roles
                search.SearchScope = SearchScope.Subtree;
                search.ReferralChasing = ReferralChasingOption.All;
                search.PropertiesToLoad.AddRange(properties);
                //search.PropertiesToLoad.Add("*");
                search.Filter = filter;

                //search.PropertiesToLoad.Add("cn");
                //search.PropertiesToLoad.Add("mail");

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