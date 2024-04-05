
namespace api
{
    funcdef int int_GetFunction();
    class int_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private int_GetFunction@ m_getFunctionInt;

        int_WrapObj(int_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionInt = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionInt());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
