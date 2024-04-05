
namespace api
{
    funcdef int64 int64_GetFunction();
    class int64_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private int64_GetFunction@ m_getFunctionInt64;

        int64_WrapObj(int64_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionInt64 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionInt64());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
