
namespace api
{
    funcdef int8 int8_GetFunction();
    class int8_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private int8_GetFunction@ m_getFunctionInt8;

        int8_WrapObj(int8_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionInt8 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionInt8());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
