﻿using Common.Enums;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Infrastructure
{
    public class DisplayFormatHelper
    {
        public NumberFormatInfo NumberFormat()
        {
            var format = (NumberFormatInfo)CultureInfo.InvariantCulture.NumberFormat.Clone();
            format.NumberGroupSeparator = ".";
            format.NumberDecimalSeparator = ",";
            return format;
        }

        public string FullDateFormat = "d MMMM yyyy"; //1 Januari 2014
        public string MonthYearDateFormat = "MMMM yyyy"; //Januari 2014
        public string SqlDateFormat = "yyyy-MM-dd"; //2014-01-31
        public string CompactDateFormat = "M/d/yy"; //5/18/14
        public string JavascriptDateFormat = "o"; //Jun 5, 2014 format yang bs diparse oleh javascript Date()
        //public string JavascriptDateFormat = "MMM d, yyyy"; //Jun 5, 2014 format yang bs diparse oleh javascript Date()

        public string FullDateTimeFormat = "d MMMM yyyy (HH:mm)"; //1 Januari 2015 (12:58)

        public string JsFullDateFormat = "{0:dd MMMM yyyy}";
        public string JsCompactDateFormat = "{0:dd MMM yyyy}";
        public string JsFullDateTimeFormat = "{0:dd MMMM yyyy (HH:mm)}";
        public string JsCompactDateTimeFormat = "{0:dd MMM yyyy (HH:mm)}";
        public string JsTimeFormat = "{0:HH:mm}";
        /// <summary>
        /// Produces optional, URL-friendly version of a title, "like-this-one". 
        /// hand-tuned for speed, reflects performance refactoring contributed
        /// by John Gietzen (user otac0n) 
        /// </summary>
        public string URLFriendly(string title)
        {
            if (title == null) return "";

            const int maxlen = 80;
            int len = title.Length;
            bool prevdash = false;
            var sb = new StringBuilder(len);
            char c;

            for (int i = 0; i < len; i++)
            {
                c = title[i];
                if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
                {
                    sb.Append(c);
                    prevdash = false;
                }
                else if (c >= 'A' && c <= 'Z')
                {
                    // tricky way to convert to lowercase
                    sb.Append((char)(c | 32));
                    prevdash = false;
                }
                else if (c == ' ' || c == ',' || c == '.' || c == '/' ||
                    c == '\\' || c == '-' || c == '_' || c == '=')
                {
                    if (!prevdash && sb.Length > 0)
                    {
                        sb.Append('-');
                        prevdash = true;
                    }
                }
                else if ((int)c >= 128)
                {
                    int prevlen = sb.Length;
                    sb.Append(RemapInternationalCharToAscii(c));
                    if (prevlen != sb.Length) prevdash = false;
                }
                if (i == maxlen) break;
            }

            if (prevdash)
                return sb.ToString().Substring(0, sb.Length - 1);
            else
                return sb.ToString();
        }

        public static string RemapInternationalCharToAscii(char c)
        {
            string s = c.ToString().ToLowerInvariant();
            if ("àåáâäãåą".Contains(s))
            {
                return "a";
            }
            else if ("èéêëę".Contains(s))
            {
                return "e";
            }
            else if ("ìíîïı".Contains(s))
            {
                return "i";
            }
            else if ("òóôõöøőð".Contains(s))
            {
                return "o";
            }
            else if ("ùúûüŭů".Contains(s))
            {
                return "u";
            }
            else if ("çćčĉ".Contains(s))
            {
                return "c";
            }
            else if ("żźž".Contains(s))
            {
                return "z";
            }
            else if ("śşšŝ".Contains(s))
            {
                return "s";
            }
            else if ("ñń".Contains(s))
            {
                return "n";
            }
            else if ("ýÿ".Contains(s))
            {
                return "y";
            }
            else if ("ğĝ".Contains(s))
            {
                return "g";
            }
            else if (c == 'ř')
            {
                return "r";
            }
            else if (c == 'ł')
            {
                return "l";
            }
            else if (c == 'đ')
            {
                return "d";
            }
            else if (c == 'ß')
            {
                return "ss";
            }
            else if (c == 'Þ')
            {
                return "th";
            }
            else if (c == 'ĥ')
            {
                return "h";
            }
            else if (c == 'ĵ')
            {
                return "j";
            }
            else
            {
                return "";
            }
        }

        /// <summary>
        /// format filepath: ~/.../.../.../sample.ext
        /// </summary>
        /// <param name="fullPath"></param>
        /// <returns>sample.ext</returns>
        public string GetFileNameFromFilePath(string fullPath)
        {
            string filename = "";
            string[] split = fullPath.Split('/');
            //split = split.Last().Split('.');
            //filename = split.FirstOrDefault();
            filename = split.Last();

            return filename;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="uniqueName">23b9b72b-9c81-4949-a51c-ceaae4bb4e73_getting-started.pdf</param>
        /// <returns>getting-started.pdf</returns>
        public string GetFileNameFromUniqueFileName(string uniqueName)
        {
            string filename = "";
            List<string> split = uniqueName.Split('_').ToList();
            split.RemoveAt(0);
            filename = string.Join("", split);

            return filename;
        }

        public List<SelectListItem> EnumToSelectList<T>(bool order = true)
        {
            List<SelectListItem> result = new List<SelectListItem>();
            EnumHelper eh = new EnumHelper();
            List<T> enumValList = EnumExtension.EnumToList<T>().ToList();
            Type enumType = typeof(T);
            Enum en;
            
            foreach (T single in enumValList)
            {
                en = (Enum)Enum.Parse(enumType, single.ToString());
                result.Add(new SelectListItem { Text = eh.GetEnumDescription(en), Value = single.ToString() });
            }

            if(order)
                result = result.OrderBy(m => m.Text).ToList();

            return result;
        }


        public string NumberFormat<T>(T s)
        {
            return string.Format("{0:n}", s);
        }
    }
}