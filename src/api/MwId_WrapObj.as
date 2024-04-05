
namespace api
{
    funcdef MwId MwId_GetFunction();
    class MwId_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private MwId_GetFunction@ m_getFunctionMwId;

        MwId_WrapObj(MwId_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionMwId = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return "MwId";
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            if (name == "Value")
            {
                return GetValue_WrapObj();
            }
            else if (name == "Name")
            {
                return GetName_WrapObj();
            }
            return null;
        }

        private uint Getuint_Value()
        {
            auto self = m_getFunctionMwId();
            return self.Value;
        }
        private uint_WrapObj@ m_wrapObjValue = null;
        uint_WrapObj@ GetValue_WrapObj()
        {
            if (m_wrapObjValue is null)
            {
                @m_wrapObjValue = uint_WrapObj(uint_GetFunction(this.Getuint_Value), "Value", m_qualifiedName + ".Value");
            }
            return m_wrapObjValue;
        }

        private string Getstring_Name()
        {
            auto self = m_getFunctionMwId();
            return self.GetName();
        }
        private string_WrapObj@ m_wrapObjName = null;
        string_WrapObj@ GetName_WrapObj()
        {
            if (m_wrapObjName is null)
            {
                @m_wrapObjName = string_WrapObj(string_GetFunction(this.Getstring_Name), "Name", m_qualifiedName + ".Name");
            }
            return m_wrapObjName;
        }
    }
}
