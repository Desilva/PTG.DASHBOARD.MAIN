﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class PTGMainEntities : DbContext
    {
        public PTGMainEntities()
            : base("name=PTGMainEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Action> Actions { get; set; }
        public virtual DbSet<Application> Applications { get; set; }
        public virtual DbSet<Membership> Memberships { get; set; }
        public virtual DbSet<Module> Modules { get; set; }
        public virtual DbSet<ModulesInRole> ModulesInRoles { get; set; }
        public virtual DbSet<Risk> Risks { get; set; }
        public virtual DbSet<RiskDocument> RiskDocuments { get; set; }
        public virtual DbSet<RiskImpact> RiskImpacts { get; set; }
        public virtual DbSet<RiskMitigation> RiskMitigations { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<log> logs { get; set; }
    }
}