//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Business.Entities
{
    using System;
    using System.Collections.Generic;
    
    public partial class log
    {
        public long id { get; set; }
        public System.DateTime timestamp { get; set; }
        public string application { get; set; }
        public string ip { get; set; }
        public string user { get; set; }
        public string action { get; set; }
        public string data { get; set; }
    }
}