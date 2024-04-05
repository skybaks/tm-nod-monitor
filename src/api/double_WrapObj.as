
namespace api
{
    funcdef double double_GetFunction();
    class double_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private double_GetFunction@ m_getFunctionDouble;

        double_WrapObj(double_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionDouble = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionDouble());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
