
namespace api
{
    funcdef DataRef DataRef_GetFunction();
    class DataRef_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private DataRef_GetFunction@ m_getFunctionDataRef;

        DataRef_WrapObj(DataRef_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionDataRef = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return "DataRef";
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            if (name == "Filename")
            {
                return GetFilename_WrapObj();
            }
            return null;
        }

        private wstring Getwstring_Filename()
        {
            auto self = m_getFunctionDataRef();
            return self.Filename;
        }
        private wstring_WrapObj@ m_wrapObjFilename = null;
        wstring_WrapObj@ GetFilename_WrapObj()
        {
            if (m_wrapObjFilename is null)
            {
                @m_wrapObjFilename = wstring_WrapObj(wstring_GetFunction(this.Getwstring_Filename), "Filename", m_qualifiedName + ".Filename");
            }
            return m_wrapObjFilename;
        }
    }
}
