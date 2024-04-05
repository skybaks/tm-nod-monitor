
namespace api
{
    funcdef int3 int3_GetFunction();
    class int3_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private int3_GetFunction@ m_getFunctionInt3;

        int3_WrapObj(int3_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionInt3 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionInt3());
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

        private int Getint_x()
        {
            auto self = m_getFunctionInt3();
            return self.x;
        }
        private int_WrapObj@ m_wrapObjx = null;
        int_WrapObj@ Getx_WrapObj()
        {
            if (m_wrapObjx is null)
            {
                @m_wrapObjx = int_WrapObj(int_GetFunction(this.Getint_x), "x", m_qualifiedName + ".x");
            }
            return m_wrapObjx;
        }

        private int Getint_y()
        {
            auto self = m_getFunctionInt3();
            return self.y;
        }
        private int_WrapObj@ m_wrapObjy = null;
        int_WrapObj@ Gety_WrapObj()
        {
            if (m_wrapObjy is null)
            {
                @m_wrapObjy = int_WrapObj(int_GetFunction(this.Getint_y), "y", m_qualifiedName + ".y");
            }
            return m_wrapObjy;
        }

        private int Getint_z()
        {
            auto self = m_getFunctionInt3();
            return self.z;
        }
        private int_WrapObj@ m_wrapObjz = null;
        int_WrapObj@ Getz_WrapObj()
        {
            if (m_wrapObjz is null)
            {
                @m_wrapObjz = int_WrapObj(int_GetFunction(this.Getint_z), "z", m_qualifiedName + ".z");
            }
            return m_wrapObjz;
        }
    }
}
