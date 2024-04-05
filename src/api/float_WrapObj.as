
namespace api
{
    funcdef float float_GetFunction();
    class float_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private float_GetFunction@ m_getFunctionFloat;

        float_WrapObj(float_GetFunction@ getFunction, const string&in name, const string& qualifiedName)
        {
            @m_getFunctionFloat = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionFloat());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            return null;
        }
    }
}
