using System;
using System.Reflection;

namespace Business.Extension
{
    public static class ReflectionExtension
    {
        public static object GetPropValue(this object obj, string name)
        {
            foreach (string part in name.Split('.'))
            {
                if (obj == null)
                    return null;

                Type type = obj.GetType();
                PropertyInfo info = type.GetProperty(part);
                if (info == null)
                    return null;

                obj = info.GetValue(obj, null);
            }
            return obj;
        }

        public static T GetPropValue<T>(this object obj, string name)
        {
            object retval = GetPropValue(obj, name);
            if (retval == null)
                return default(T);

            return (T)retval;
        }
    }
}
