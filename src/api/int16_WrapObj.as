
namespace api
{
    funcdef int16 int16_GetFunction();
    class int16_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private int16_GetFunction@ m_getFunctionInt16;

        int16_WrapObj(int16_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionInt16 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionInt16());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
