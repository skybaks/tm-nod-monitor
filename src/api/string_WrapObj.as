
namespace api
{
    funcdef string string_GetFunction();
    class string_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private string_GetFunction@ m_getFunctionString;

        string_WrapObj(string_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionString = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionString());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
