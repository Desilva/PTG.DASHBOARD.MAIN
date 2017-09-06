using Business.Entities;
using Business.Extension;
using Business.Infrastructure;
using Business.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Threading.Tasks;

namespace Business.Abstract
{
    public abstract class BaseRepository<TEntity> : BaseRepository<TEntity, PTGMainEntities, int>, IRepository<TEntity>
        where TEntity : class
    {
    }

    public abstract class BaseRepository<TEntity, TKey> : BaseRepository<TEntity, PTGMainEntities, TKey>, IRepository<TEntity, TKey>
        where TEntity : class
        where TKey : IEquatable<TKey>
    {
    }

    public abstract class BaseRepository<TEntity, TContext, TKey> : IRepository<TEntity, TKey>
        where TEntity : class
        where TContext : DbContext, new()
        where TKey : IEquatable<TKey>
    {
        #region Variables

        private TKey _id;
        private bool _disposed;
        private TContext _context = new TContext();

        #endregion

        #region Properties

        protected TContext Context
        {
            get
            {
                return _context;
            }
            set
            {
                _context = value;
            }
        }

        protected IDbSet<TEntity> EntitySet
        {
            get
            {
                return Context.Set<TEntity>();
            }
        }

        public TKey Id
        {
            get
            {
                return _id;
            }
            protected set
            {
                _id = value;
            }
        }

        #endregion

        #region Synchronous

        public virtual List<TEntity> Find(
            int? skip = null, 
            int? take = null, 
            List<SortingInfo> sortings = null, 
            FilterInfo filters = null,
            bool includeDeleted = false)
        {
            ThrowIfDisposed();
            IQueryable<TEntity> list = EntitySet;

            //filters data with delete flag
            if (!includeDeleted)
            {
                if (filters == null || filters.Filters == null)
                {
                    filters = new FilterInfo
                    {
                        Logic = "and",
                        Filters = new List<FilterInfo>()
                    };
                }

                if (!filters.Filters.Where(x => x.Field == "IsDeleted").Any())
                {
                    filters.Filters.Add(new FilterInfo
                    {
                        Field = "IsDeleted",
                        Operator = "eq",
                        Value = false.ToString()
                    });
                }
            }

            if (filters != null && (filters.Filters != null && filters.Filters.Count > 0))
            {
                //filters.FormatFieldToUnderscore();
                GridHelper.ProcessFilters(filters, ref list);
            }

            if (sortings != null && sortings.Count > 0)
            {
                foreach (var s in sortings)
                {
                    //s.FormatSortOnToUnderscore();
                    list = list.OrderBy(string.Format("{0} {1}", s.SortOn, s.SortOrder));
                }
            }
            else
            {
                EntityHelper<TEntity> eh = new EntityHelper<TEntity>(Context);
                var primaryKeyName = eh.FindPrimaryKeyName();
                list = list.OrderBy(string.Format("{0} desc", primaryKeyName)); //default, wajib ada atau EF error
            }

            //take & skip
            var takeList = list;
            if (skip != null)
            {
                takeList = takeList.Skip(skip.Value);
            }
            if (take != null)
            {
                takeList = takeList.Take(take.Value);
            }

            List<TEntity> result = takeList.ToList();
            return result;
        }

        public virtual TEntity FindByPk(TKey id)
        {
            ThrowIfDisposed();
            return EntitySet.Find(id);
        }
        
        public virtual int Count(FilterInfo filters = null, bool includeDeleted = false)
        {
            ThrowIfDisposed();
            IQueryable<TEntity> items = EntitySet;

            //filters data with delete flag
            if (!includeDeleted)
            {
                if (filters == null || filters.Filters == null)
                {
                    filters = new FilterInfo
                    {
                        Logic = "and",
                        Filters = new List<FilterInfo>()
                    };
                }

                if (!filters.Filters.Where(x => x.Field == "IsDeleted").Any())
                {
                    filters.Filters.Add(new FilterInfo
                    {
                        Field = "IsDeleted",
                        Operator = "eq",
                        Value = false.ToString()
                    });
                }
            }

            if (filters != null && (filters.Filters != null && filters.Filters.Count > 0))
            {
                //filters.FormatFieldToUnderscore();
                GridHelper.ProcessFilters(filters, ref items);
            }
            
            return items.Count();
        }

        public virtual void Create(TEntity dbItem)
        {
            ThrowIfDisposed();
            bool saved = false;
            
            EntitySet.Add(dbItem);
            saved = Context.SaveChanges() > 0;
            if (saved)
                GetPrimaryKeyValue(dbItem);
        }

        public virtual void Update(TEntity dbItem)
        {
            ThrowIfDisposed();
            bool saved = false;
            
            DbEntityEntry entry = Context.Entry(dbItem);
            entry.State = EntityState.Modified;
            saved = Context.SaveChanges() > 0;
            if (saved)
                GetPrimaryKeyValue(dbItem);
        }

        public virtual void Delete(TEntity dbItem)
        {
            ThrowIfDisposed();
            bool saved = false;
            
            EntitySet.Remove(dbItem);
            Context.SaveChanges();
            saved = Context.SaveChanges() > 0;
            if (saved)
                GetPrimaryKeyValue(dbItem);
        }

        #endregion

        #region Asynchronous

        public virtual Task<List<TEntity>> FindAsync(
            int? skip = null,
            int? take = null,
            List<SortingInfo> sortings = null,
            FilterInfo filters = null,
            bool includeDeleted = false)
        {
            return Task.FromResult(Find(skip, take, sortings, filters, includeDeleted));
        }

        public virtual Task<TEntity> FindByPkAsync(TKey id)
        {
            return Task.FromResult(FindByPk(id));
        }

        public virtual Task<int> CountAsync(FilterInfo filters = null, bool includeDeleted = false)
        {
            return Task.FromResult(Count(filters, includeDeleted));
        }

        public virtual Task CreateAsync(TEntity dbItem)
        {
            return Task.Run(() => Create(dbItem));
        }

        public virtual Task UpdateAsync(TEntity dbItem)
        {
            return Task.Run(() => Update(dbItem));
        }

        public virtual Task DeleteAsync(TEntity dbItem)
        {
            return Task.Run(() => Delete(dbItem));
        }
        
        #endregion

        #region Helper

        /// <summary>
        ///     Dispose repository. 
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        ///     Jika dalam posisi disposing, dispose akan memanggil Context.  Nilai Context menjadi null.
        /// </summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (disposing && Context != null)
            {
                Context.Dispose();
            }
            _disposed = true;
            Context = null;
        }

        protected void ThrowIfDisposed()
        {
            if (_disposed)
            {
                throw new ObjectDisposedException(GetType().Name);
            }
        }

        protected virtual void GetPrimaryKeyValue(TEntity dbItem)
        {
            object temp = null;
            EntityHelper<TEntity> eh = new EntityHelper<TEntity>(Context);
            var primaryKeyName = eh.FindPrimaryKeyName();
            temp = dbItem.GetPropValue(primaryKeyName);
            if (temp != null)
                Id = (TKey)Convert.ChangeType(temp, typeof(TKey));
        }
        #endregion
    }
}
