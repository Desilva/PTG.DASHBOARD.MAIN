using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Enums
{
    public enum Day
    {
        SUNDAY = 0,
        MONDAY = 1,
        TUESDAY = 2,
        WEDNESDAY = 3,
        THURSDAY = 4,
        FRIDAY = 5,
        SATURDAY = 6,
    }

    public enum MONTH
    {
        [Description("Januari")]
        JAN = 1,
        [Description("Februari")]
        FEB = 2,
        [Description("Maret")]
        MAR = 3,
        [Description("April")]
        APR = 4,
        [Description("Mei")]
        MEI = 5,
        [Description("Juni")]
        JUN = 6,
        [Description("Juli")]
        JUL = 7,
        [Description("Agustus")]
        AUG = 8,
        [Description("September")]
        SEP = 9,
        [Description("Oktober")]
        OKT = 10,
        [Description("November")]
        NOV = 11,
        [Description("Desember")]
        DES = 12,
    }


    public enum RiskClasification
    {
        [Description("Merah")]
        RED,
        [Description("Orange")]
        ORANGE,
        [Description("Kuning")]
        YELLOW,
        [Description("Hijau")]
        GREEN

    }

    public enum Measurement
    {
        [Description("Kualitatif")]
        QUALITATIVE,
        [Description("Kuantitatif")]
        QUANTITATIVE
    }

    public enum ImpactTypes
    {
        [Description("Inherent")]
        INHERENT,
        [Description("Residual")]
        RESIDUAL
    }
    
   public enum UserModule
    {
        [Description("Authorize Module")] //penanganan hak akses sementara
        AUTH_MODULE,
        [Description("Security Guard")]
        SECURITY_GUARD,
        [Description("Risk Update")]
        RISK_UPDATE_MODULE,
        [Description("Risk View")]
        RISK_VIEW_MODULE
    }

    public enum UserAction
    {
        [Description("Approve")]
        APPROVE,
        [Description("Create")]
        CREATE,
        [Description("Delete")]
        DELETE,
        [Description("Update")]
        UPDATE,
        [Description("View")]
        VIEW
    }
}
