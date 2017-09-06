using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Business.Linq;

namespace Business.Infrastructure
{
    public static class GridHelper
    {
        private static string _level1Logic = string.Empty;

        public static void ProcessFilters<T>(FilterInfo filter, ref IQueryable<T> queryable)
        {
            var whereClause = string.Empty;
            var filters = filter.Filters;
            var parameters = new List<object>();
            
            CreateWhereClause<T>(filter, ref parameters, ref whereClause);
            if (whereClause.Length > 2)
            {
                for (int i = 0; i < parameters.Count(); i++)
                {
                    if (parameters[i].GetType() == typeof(string))
                        parameters[i] = ((string)parameters[i]).ToLower();
                }

                queryable = queryable.Where(whereClause, parameters.ToArray());
            }
        }

        public static void CreateWhereClause<T>(FilterInfo filter, ref List<object> parameters, ref string whereClause, bool level2 = false)
        {
            var filters = filter.Filters;

            if (filters != null)
            {
                if (filter.Logic == null || filter.Logic == "")
                {
                    filter.Logic = "and";
                }

                if (!level2)
                    _level1Logic = filter.Logic;

                if (level2)
                {
                    whereClause += whereClause.EndsWith(")") == true ?
                        string.Format("{0}{1}", ToLinqOperator(_level1Logic), "(") : "(";
                }

                for (int i = 0; i < filters.Count; i++)
                {
                    var f = filters[i];

                    if (f.Filters == null)
                    {
                        if (!level2 && whereClause.EndsWith(")"))
                            whereClause += ToLinqOperator(filter.Logic);

                        whereClause += string.Format("{0}{1}", BuildWhereClause<T>(f, i, parameters), ToLinqOperator(filter.Logic));

                        if (i == (filters.Count - 1))
                        {
                            CleanUp(ref whereClause);

                            if (level2)
                                whereClause += ")";
                        }
                    }
                    else
                    {
                        if (level2)
                            throw new ArgumentException("FilterInfo can not more than two levels.");
                        CreateWhereClause<T>(f, ref parameters, ref whereClause, true);
                    }
                }
            }
        }

        public static void ProcessSorts<T>(List<SortingInfo> sorts, ref IQueryable<T> queryable)
        {
            var sortClause = string.Empty;
            var parameters = new List<object>();
            for (int i = 0; i < sorts.Count; i++)
            {
                var s = sorts[i];
                s.FormatSortOnToUnderscore();
                if (i != 0)
                {
                    sortClause += ", ";
                }
                sortClause += s.SortOn + " " + s.SortOrder;
            }
            queryable = queryable.OrderBy<T>(sortClause);
        }

        public static string CleanUp(ref string whereClause)
        {
            whereClause = whereClause.TrimEnd();

            if (whereClause.EndsWith("&&") || whereClause.EndsWith("||"))
                whereClause = whereClause.Remove(whereClause.Length - 3);
            return whereClause;
        }

        public static string BuildWhereClause<T>(FilterInfo filter, int index, List<object> parameters)
        {
            var entityType = (typeof(T));
            var property = entityType.GetProperty(filter.Field);

            string[] filterArray = filter.Field.Split('.');
            if (filterArray.Length > 1)
            {
                foreach (var str in filterArray)
                {
                    property = entityType.GetProperty(str);
                    entityType = property.PropertyType;
                }
            }

            var parameterIndex = parameters.Count;

            switch (filter.Operator.ToLower())
            {
                case "eq":
                case "neq":
                case "gte":
                case "gt":
                case "lte":
                case "lt":
                    //penanganan untuk atribut yang tidak terdapat di kelas (dari foreign key), misalnya contractor.name di model project
                    //kemungkinan akan bermasalah kalau atribut bukan string, misalnya contractor.id
                    if (property != null)
                    {
                        if ((typeof(DateTime?).IsAssignableFrom(property.PropertyType)) || (typeof(DateTime).IsAssignableFrom(property.PropertyType)))
                        {
                            parameters.Add(DateTime.Parse(filter.Value).Date);
                            //return string.Format("EntityFunctions.TruncateTime(" + filter.Field + ")" + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                            //update using System.Data.Entity.DbFunctions For EF 6++
                            return string.Format("DbFunctions.TruncateTime(" + filter.Field + ")" + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        if (typeof(int).IsAssignableFrom(property.PropertyType))
                        {
                            parameters.Add(int.Parse(filter.Value));
                            return string.Format(filter.Field + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        //belum ditangani di source code asli
                        if (typeof(byte?).IsAssignableFrom(property.PropertyType))
                        {
                            parameters.Add(int.Parse(filter.Value));
                            return string.Format(filter.Field + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        if (typeof(short?).IsAssignableFrom(property.PropertyType))
                        {
                            parameters.Add(int.Parse(filter.Value));
                            return string.Format(filter.Field + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        if (typeof(int?).IsAssignableFrom(property.PropertyType))
                        {
                            parameters.Add(int.Parse(filter.Value));
                            return string.Format(filter.Field + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        if (typeof(Boolean).IsAssignableFrom(property.PropertyType) || typeof(bool?).IsAssignableFrom(property.PropertyType))
                        {
                            parameters.Add(Boolean.Parse(filter.Value));
                            return string.Format(filter.Field + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        if (typeof(Guid).IsAssignableFrom(property.PropertyType))
                        {
                            parameters.Add(Guid.Parse(filter.Value));
                            return string.Format(filter.Field + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }
                        if ((typeof(DateTimeOffset?).IsAssignableFrom(property.PropertyType)) || (typeof(DateTime).IsAssignableFrom(property.PropertyType)))
                        {
                            DateTime dt = DateTime.Parse(filter.Value);
                            dt = DateTime.SpecifyKind(dt, DateTimeKind.Utc);
                            DateTimeOffset dto = dt;

                            parameters.Add(dto.ToUniversalTime());
                            //return string.Format("EntityFunctions.TruncateTime(" + filter.Field + ")" + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                            //update using System.Data.Entity.DbFunctions For EF 6++
                            return string.Format("DbFunctions.TruncateTime(" + filter.Field + ")" + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                        }

                    }
                    parameters.Add(filter.Value);
                    return string.Format(filter.Field + ".ToLower()" + ToLinqOperator(filter.Operator) + "@" + parameterIndex);
                case "startswith":
                    parameters.Add(filter.Value);
                    return filter.Field + ".StartsWith(" + "@" + parameterIndex + ")";
                case "endswith":
                    parameters.Add(filter.Value);
                    return filter.Field + ".EndsWith(" + "@" + parameterIndex + ")";
                case "contains":
                    parameters.Add(filter.Value);
                    return filter.Field + ".ToLower().Contains(" + "@" + parameterIndex + ")";
                case "doesnotcontain":
                    parameters.Add(filter.Value);
                    return "!" + filter.Field + ".Contains(" + "@" + parameterIndex + ")";
                case "isnull":
                    return string.Format(filter.Field + " == null");
                case "isnotnull":
                    return string.Format(filter.Field + " != null");
                default:
                    throw new ArgumentException("This operator is not yet supported for this Grid", filter.Operator);
            }
        }

        public static string ToLinqOperator(string @operator)
        {
            switch (@operator.ToLower())
            {
                case "eq": return " == ";
                case "neq": return " != ";
                case "gte": return " >= ";
                case "gt": return " > ";
                case "lte": return " <= ";
                case "lt": return " < ";
                case "or": return " || ";
                case "and": return " && ";
                default: return null;
            }
        }
    }
}
