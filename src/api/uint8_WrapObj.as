
namespace api
{
    funcdef uint8 uint8_GetFunction();
    class uint8_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private uint8_GetFunction@ m_getFunctionUint8;

        uint8_WrapObj(uint8_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionUint8 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionUint8());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
