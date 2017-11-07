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
            IsAuthenticated = false;
            
            string domain = ConfigurationManager.AppSettings["LDAPHost"].ToString();
            
            DirectoryEntry entry = new DirectoryEntry(domain, username, password);
            try
            {
                DirectorySearcher search = new DirectorySearcher(entry);
                string str = string.Format("(&(ObjectClass={0})(sAMAccountName={1}))", "person", username);
                string[] strArrays = new string[] { "fullname", "cn", "mail" };
                search.SearchScope = SearchScope.Subtree;
                search.ReferralChasing = ReferralChasingOption.All;
                search.PropertiesToLoad.AddRange(strArrays);
                search.Filter = str;
                SearchResult result = search.FindOne();

                if (result != null)
                {
                    Roles.Add((string)result.Properties["cn"][0]);
                    if (result.Properties["mail"] != null && result.Properties["mail"].Count > 0)
                        Email = (string)result.Properties["mail"][0];
                    else
                        Email = "-";
                    IsAuthenticated = true;
                }

            }
            catch (Exception ex)
            {
                IsAuthenticated = false;
            }

        }
    }
}