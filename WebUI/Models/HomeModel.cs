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
using WebUI.Areas.Risk.Models.RiskImpact;

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
            if (account == "Pertumbuhan Pendapatan Usaha") Account = "Pertumbuhan Pendapatan";
            else Account = account;

            string USDStrReplaced = "USD ";
            string USDStrReplacer = " (USD)";
            if (value.StartsWith(USDStrReplaced))
            {
                Value = value.Replace(USDStrReplaced, "");
                Account = Account + USDStrReplacer;
            }
            else
            {
                Value = value;
            }
            
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
            if (LastUpdate != "-")
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

            double valueTemp = 0;
            if (double.TryParse(value, out valueTemp))
            {
                valueTemp = Math.Round(valueTemp, 2);
                value = valueTemp.ToString();
            }
            Value = value;
            Persen = persen;
        }
    }

    public class TopRiskTableModel
    {
        public int ROW_COUNT = 5;
        public int COL_COUNT = 5;
        public TopRiskTableCellModel[][] TopRiskTableCell;

        public TopRiskTableModel(List<RiskImpactPresentationStub> riskImpactList)
        {
            TopRiskTableCell = new TopRiskTableCellModel[ROW_COUNT][];
            for (int i = 0; i < ROW_COUNT; i++)
            {
                TopRiskTableCell[i] = new TopRiskTableCellModel[COL_COUNT];
                for (int j = 0; j < COL_COUNT; j++)
                {
                    TopRiskTableCell[i][j] = new TopRiskTableCellModel(i+1, j+1);
                }
            }

            int row = 0;
            int col = 0;
            foreach (RiskImpactPresentationStub riskImpact in riskImpactList)
            {
                row = 6 - riskImpact.Probability.Value; //prob 5 jadi row 1, prob 1 jadi row 5
                col = riskImpact.Impact.Value; //impact 1 jadi col 1, impact 5 jadi row 5
                row = (row >= 1) ? ((row <= 5) ? row : 5) : 1; // row harus di antara 1-5
                col = (col >= 1) ? ((col <= 5) ? col : 5) : 1; // col harus di antara 1-5
                
                TopRiskTableCell[row - 1][col - 1].RiskImpactList.Add(riskImpact);
            }
        }
    }

    public class TopRiskTableCellModel
    {
        public List<RiskImpactPresentationStub> RiskImpactList;
        public int RiskPoint;
        public string CellClass;

        public TopRiskTableCellModel()
        {
            RiskImpactList = new List<RiskImpactPresentationStub>();
            RiskPoint = 0;
            CellClass = "";
        }

        public TopRiskTableCellModel(int row, int col)
        {
            RiskImpactList = new List<RiskImpactPresentationStub>();

            //row = (row >= 1) ? ((row <= 5) ? row : 5) : 1; // row harus di antara 1-5
            //col = (col >= 1) ? ((col <= 5) ? col : 5) : 1; // col harus di antara 1-5
            int probability = 6 - row; //row 1 utk prob 5, row 5 utk prob 1
            int impact = col; //col 1 utk impact 1, col 5 utk impact 5

            RiskPoint = probability * impact;
            if (RiskPoint <= 3)
                CellClass = "low";
            else if (RiskPoint <= 4)
                CellClass = "medlow";
            else if (RiskPoint <= 9)
                CellClass = "med";
            else if (RiskPoint <= 12)
                CellClass = "medhigh";
            else //if (RiskPoint <= 25)
                CellClass = "high";
        }

        public List<int> GetRiskIdList()
        {
            List<int> riskIdList = new List<int>();
            foreach (RiskImpactPresentationStub riskImpact in RiskImpactList)
            {
                riskIdList.Add(riskImpact.RiskId);
            }
            return riskIdList.Distinct().ToList();
        }
    }
}