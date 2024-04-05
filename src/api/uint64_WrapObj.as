
namespace api
{
    funcdef uint64 uint64_GetFunction();
    class uint64_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private uint64_GetFunction@ m_getFunctionUint64;

        uint64_WrapObj(uint64_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionUint64 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionUint64());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
