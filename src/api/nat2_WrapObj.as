
namespace api
{
    funcdef nat2 nat2_GetFunction();
    class nat2_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private nat2_GetFunction@ m_getFunctionNat2;

        nat2_WrapObj(nat2_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionNat2 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionNat2());
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            if (name == "x")
            {
                return Getx_WrapObj();
            }
            else if (name == "y")
            {
                return Gety_WrapObj();
            }
            return null;
        }

        private uint Getuint_x()
        {
            auto self = m_getFunctionNat2();
            return self.x;
        }
        private uint_WrapObj@ m_wrapObjx = null;
        uint_WrapObj@ Getx_WrapObj()
        {
            if (m_wrapObjx is null)
            {
                @m_wrapObjx = uint_WrapObj(uint_GetFunction(this.Getuint_x), "x", m_qualifiedName + ".x");
            }
            return m_wrapObjx;
        }

        private uint Getuint_y()
        {
            auto self = m_getFunctionNat2();
            return self.y;
        }
        private uint_WrapObj@ m_wrapObjy = null;
        uint_WrapObj@ Gety_WrapObj()
        {
            if (m_wrapObjy is null)
            {
                @m_wrapObjy = uint_WrapObj(uint_GetFunction(this.Getuint_y), "y", m_qualifiedName + ".y");
            }
            return m_wrapObjy;
        }
    }
}
