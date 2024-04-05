
namespace api
{
    funcdef uint16 uint16_GetFunction();
    class uint16_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private uint16_GetFunction@ m_getFunctionUint16;

        uint16_WrapObj(uint16_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionUint16 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionUint16());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
