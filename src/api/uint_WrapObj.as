
namespace api
{
    funcdef uint uint_GetFunction();
    class uint_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private uint_GetFunction@ m_getFunctionUint;

        uint_WrapObj(uint_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionUint = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionUint());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
