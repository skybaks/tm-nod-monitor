
namespace api
{
    funcdef wstring wstring_GetFunction();
    class wstring_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private wstring_GetFunction@ m_getFunctionWstring;

        wstring_WrapObj(wstring_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionWstring = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionWstring());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
