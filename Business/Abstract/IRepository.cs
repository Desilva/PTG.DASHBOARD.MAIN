using Business.Infrastructure;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Business.Abstract
{
    /// <summary>
    ///     Interface yang mengekspos manajemen dasar repository.
    /// </summary>
    /// <typeparam name="TEntity">Tipe yang mengenkapsulasi entity.</typeparam>
    /// <typeparam name="TKey">Tipe yang mengenkapsulasi primary key.</typeparam>
    public interface IRepository<TEntity> : IRepository<TEntity, int>
        where TEntity : class
    {
    }

    /// <summary>
    ///     Interface yang mengekspos manajemen dasar repository.
    /// </summary>
    /// <typeparam name="TEntity">Tipe yang mengenkapsulasi entity.</typeparam>
    /// <typeparam name="TKey">Tipe yang mengenkapsulasi primary key.</typeparam>
    public interface IRepository<TEntity, TKey> : IDisposable
        where TEntity : class
        where TKey : IEquatable<TKey>
    {
        #region Properties

        /// <summary>
        /// Primary key dari data.
        /// </summary>
        TKey Id
        {
            get;
        }

        #endregion

        #region Synchronous

        /// <summary>
        /// Melakukan listing terhadap data dengan skip beberapa data di awal, mengambil beberapa data dari hasil sorting yang sudah di filter terlebih dahulu.
        /// </summary>
        /// <param name="skip">Jumlah data yang tidak diambil diawal.</param>
        /// <param name="take">Jumlah data yang diambil.</param>
        /// <param name="sortings">Jenis sorting yang dilakukan</param>
        /// <param name="filters">Filter yang dilakukan terhadap data</param>
        /// <returns>List data yang telah difilter, disort, dan diambil beberapa bagian.</returns>
        List<TEntity> Find(int? skip = null, int? take = null, List<SortingInfo> sortings = null, FilterInfo filters = null, bool includeDeleted = false);

        /// <summary>
        /// Mendapatkan data berdasarkan Id.
        /// </summary>
        /// <param name="id">Id dari data</param>
        /// <returns>data berdasarkan Id</returns>
        TEntity FindByPk(TKey id);

        /// <summary>
        /// Menghitung total semua data yang ter-filter.
        /// </summary>
        /// <param name="filters">Filter yang dilakukan terhadap data.</param>
        /// <returns>total data yang masuk dalam filter yang dilakukan.</returns>
        int Count(FilterInfo filters = null, bool includeDeleted = false);

        /// <summary>
        /// Menambahkan data baru ke dalam database.
        /// </summary>
        /// <param name="dbItem">Data yang akan dimasukkan ke dalam database.</param>
        void Create(TEntity dbItem);

        /// <summary>
        /// Merubah sebuah data yang sudah difilter berdasarkan Id.
        /// </summary>
        /// <param name="dbItem">Data yang akan dimasukkan ke dalam database.</param>
        void Update(TEntity dbItem);

        /// <summary>
        /// Menghapus sebuah data yang sudah difilter berdasarkan Id.
        /// </summary>
        /// <param name="dbItem">Data yang akan dimasukkan ke dalam database.</param>
        void Delete(TEntity dbItem);

        #endregion

        #region Asynchronous

        /// <summary>
        /// Melakukan listing terhadap data dengan skip beberapa data di awal, mengambil beberapa data dari hasil sorting yang sudah di filter terlebih dahulu.
        /// </summary>
        /// <param name="skip">Jumlah data yang tidak diambil diawal.</param>
        /// <param name="take">Jumlah data yang diambil.</param>
        /// <param name="sortings">Jenis sorting yang dilakukan</param>
        /// <param name="filters">Filter yang dilakukan terhadap data</param>
        /// <returns>List data yang telah difilter, disort, dan diambil beberapa bagian.</returns>
        Task<List<TEntity>> FindAsync(int? skip = null, int? take = null, List<SortingInfo> sortings = null, FilterInfo filters = null, bool includeDeleted = false);

        /// <summary>
        /// Mendapatkan data berdasarkan Id.
        /// </summary>
        /// <param name="id">Id dari data</param>
        /// <returns>data berdasarkan Id</returns>
        Task<TEntity> FindByPkAsync(TKey id);

        /// <summary>
        /// Menghitung total semua data yang ter-filter.
        /// </summary>
        /// <param name="filters">Filter yang dilakukan terhadap data.</param>
        /// <returns>total data yang masuk dalam filter yang dilakukan.</returns>
        Task<int> CountAsync(FilterInfo filters = null, bool includeDeleted = false);

        /// <summary>
        /// Menambahkan data baru ke dalam database.
        /// </summary>
        /// <param name="dbItem">Data yang akan dimasukkan ke dalam database.</param>
        Task CreateAsync(TEntity dbItem);

        /// <summary>
        /// Merubah sebuah data yang sudah difilter berdasarkan Id.
        /// </summary>
        /// <param name="dbItem">Data yang akan dimasukkan ke dalam database.</param>
        Task UpdateAsync(TEntity dbItem);

        /// <summary>
        /// Menghapus sebuah data yang sudah difilter berdasarkan Id.
        /// </summary>
        /// <param name="dbItem">Data yang akan dimasukkan ke dalam database.</param>
        Task DeleteAsync(TEntity dbItem);

        #endregion
    }
}
