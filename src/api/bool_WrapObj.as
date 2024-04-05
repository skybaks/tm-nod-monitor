
namespace api
{
    funcdef bool bool_GetFunction();
    class bool_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private bool_GetFunction@ m_getFunctionBool;

        bool_WrapObj(bool_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionBool = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionBool());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
