﻿using Business.Abstract;
using Business.Entities;
using Business.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Linq;
using System.Text.RegularExpressions;

namespace Business.Concrete
{
    public class EFModulesInRoleRepository : IModulesInRoleRepository
    {
        private PTGMainEntities context = new PTGMainEntities();

        public ModulesInRole FindByRoleAndModule(Guid roleId, Guid moduleId) {
            return context.ModulesInRoles.Where(x => x.RoleId == roleId).Where(x=>x.ModuleId == moduleId).FirstOrDefault();
        }

        public void RemoveAction(Guid moduleId, Guid actionId) {
            var modulesInRole = context.ModulesInRoles.Where(x => x.ModuleId == moduleId).ToList();
            foreach (ModulesInRole mr in modulesInRole) {
                mr.Actions.Remove(context.Actions.Find(actionId));
            }
            context.SaveChanges();
        }

        public List<ModulesInRole> FindAll()
        {
            return context.ModulesInRoles.ToList();
        }

        /*
         * Delete all ModulesInRole if doesn't have actions
         * 
         * @param moduleId
         */
        public void DeleteByModule(Guid moduleId) {
            var modulesInRole = context.ModulesInRoles.Where(x => x.ModuleId == moduleId).ToList();
            foreach (ModulesInRole mr in modulesInRole)
            {
                if (mr.Actions.Count <= 0) {
                    context.ModulesInRoles.Remove(mr);
                }
                
            }
            context.SaveChanges();
        }

        /*
         * Delete all ModulesInRole by Role
         * 
         * 
         * @param moduleId
         */
        public void DeleteByRole(Guid roleId)
        {
            var modulesInRole = context.ModulesInRoles.Where(x => x.RoleId == roleId).ToList();
            foreach (ModulesInRole mr in modulesInRole)
            {
                if (mr.Actions.Count > 0)
                {
                    mr.Actions.Clear();
                }
                context.ModulesInRoles.Remove(mr);

            }
            context.SaveChanges();
        }
        
    }
}
