
namespace api
{
    funcdef nat3 nat3_GetFunction();
    class nat3_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private nat3_GetFunction@ m_getFunctionNat3;

        nat3_WrapObj(nat3_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionNat3 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionNat3());
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
            else if (name == "z")
            {
                return Getz_WrapObj();
            }
            return null;
        }

        private uint Getuint_x()
        {
            auto self = m_getFunctionNat3();
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
            auto self = m_getFunctionNat3();
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

        private uint Getuint_z()
        {
            auto self = m_getFunctionNat3();
            return self.z;
        }
        private uint_WrapObj@ m_wrapObjz = null;
        uint_WrapObj@ Getz_WrapObj()
        {
            if (m_wrapObjz is null)
            {
                @m_wrapObjz = uint_WrapObj(uint_GetFunction(this.Getuint_z), "z", m_qualifiedName + ".z");
            }
            return m_wrapObjz;
        }
    }
}
