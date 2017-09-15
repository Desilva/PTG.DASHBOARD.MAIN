using Business.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Enums;
using WebUI.Infrastructure.Validation;
using System.Globalization;
using System.Threading;

namespace WebUI.Models
{
    /// <summary>
    /// model untuk mengembalikan response ke client side via ajax
    /// </summary>
    /// 

    public class HomeResponseModel
    {
        public int total;
        public List<HomeDataModel> data;
        public int status;
        public string message;

        public HomeResponseModel()
        {
            total = 0;
            data = new List<HomeDataModel>();
            status = 0;
            message = "";
        }
    }

    public class HomeDataModel
    {
        public string lastUpdate;
        public List<HomeItemModel> item;

        public HomeDataModel()
        {
            lastUpdate = "";
            item = new List<HomeItemModel>();
        }
    }

    public class HomeItemModel
    {
        public string account;
        public string value;
        public string persen;

        public HomeItemModel()
        {
            account = "";
            value = "";
            persen = "";
        }
    }

    public class HomeFinanceModel
    {
        public string LastUpdate;
        public DateTime LastUpdateDate;
        public Dictionary<string, HomeFinanceItemModel> financeItems;

        public HomeFinanceModel()
        {
            LastUpdate = "";
            financeItems = new Dictionary<string, HomeFinanceItemModel>();
        }

        public HomeFinanceModel(HomeDataModel data)
        {
            LastUpdate = data.lastUpdate;
            Thread.CurrentThread.CurrentCulture = new CultureInfo("id-ID");
            LastUpdateDate = DateTime.ParseExact(LastUpdate, "MMM yyyy", null);

            financeItems = new Dictionary<string, HomeFinanceItemModel>();
            foreach (HomeItemModel item in data.item)
            {
                financeItems.Add(item.account, new HomeFinanceItemModel(item.account, item.value, item.persen));
            }
        }
    }

    public class HomeFinanceItemModel
    {
        public string Account;
        public string Value;
        public string Persen;

        public HomeFinanceItemModel()
        {
            Account = "";
            Value = "";
            Persen = "";
        }

        public HomeFinanceItemModel(string account, string value, string persen)
        {
            if (account == "Pertumbuhan Pendapatan Usaha") Account = "Pendapatan";
            else if (account == "EBITDA Margin") Account = "Laba Usaha";
            else Account = account;

            Value = value;
            Persen = persen;
        }
    }

    public class HomeOperationModel
    {
        public string LastUpdate;
        public DateTime LastUpdateDate;
        public Dictionary<string, HomeOperationItemModel> OperationItems;

        public HomeOperationModel()
        {
            LastUpdate = "";
            OperationItems = new Dictionary<string, HomeOperationItemModel>();
        }

        public HomeOperationModel(HomeDataModel data)
        {
            LastUpdate = data.lastUpdate;
            Thread.CurrentThread.CurrentCulture = new CultureInfo("id-ID");
            LastUpdateDate = DateTime.ParseExact(LastUpdate, "MMM yyyy", null);

            OperationItems = new Dictionary<string, HomeOperationItemModel>();
            foreach (HomeItemModel item in data.item)
            {
                OperationItems.Add(item.account, new HomeOperationItemModel(item.account, item.value, item.persen));
            }
        }
    }

    public class HomeOperationItemModel
    {
        public string Account;
        public string Value;
        public string Persen;

        public HomeOperationItemModel()
        {
            Account = "";
            Value = "";
            Persen = "";
        }

        public HomeOperationItemModel(string account, string value, string persen)
        {
            Account = account;
            Value = value;
            Persen = persen;
        }
    }
}