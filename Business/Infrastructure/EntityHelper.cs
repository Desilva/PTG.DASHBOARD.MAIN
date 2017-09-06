using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Infrastructure
{
    internal class EntityHelper<TEntity> where TEntity : class
    {
        private DbContext _context;

        public EntityHelper(DbContext context)
        {
            _context = context;
        }

        public string[] FindPrimaryKeyNames()
        {
            var objectSet = ((IObjectContextAdapter)_context).ObjectContext.CreateObjectSet<TEntity>();
            var keyNames = objectSet.EntitySet.ElementType.KeyMembers.Select(k => k.Name).ToArray();
            return keyNames;
        }
        public string FindPrimaryKeyName()
        {
            var objectSet = ((IObjectContextAdapter)_context).ObjectContext.CreateObjectSet<TEntity>();
            var keyNames = objectSet.EntitySet.ElementType.KeyMembers.Select(k => k.Name).ToArray();
            return keyNames[0];
        }

        public Type[] FindPrimaryKeyTypes()
        {
            var keyNames = FindPrimaryKeyNames();
            var types = keyNames.Select(keyName => typeof(TEntity).GetProperty(keyName).PropertyType).ToArray();
            return types;
        }

        public Type FindPrimaryKeyType()
        {
            var keyNames = FindPrimaryKeyNames();
            var types = keyNames.Select(keyName => typeof(TEntity).GetProperty(keyName).PropertyType).ToArray();
            return types[0];
        }

        public object[] FindPrimaryKeyDefaultValues()
        {
            var types = FindPrimaryKeyTypes();
            var defaultValues = types.Select(type => type.IsValueType ? Activator.CreateInstance(type) : null).ToArray();
            return defaultValues;
        }
    }
}
