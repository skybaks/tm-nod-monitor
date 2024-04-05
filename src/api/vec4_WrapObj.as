
namespace api
{
    funcdef vec4 vec4_GetFunction();
    class vec4_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private vec4_GetFunction@ m_getFunctionVec4;

        vec4_WrapObj(vec4_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionVec4 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return tostring(m_getFunctionVec4());
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
            else if (name == "w")
            {
                return Getw_WrapObj();
            }
            return null;
        }

        private float Getfloat_x()
        {
            auto self = m_getFunctionVec4();
            return self.x;
        }
        private float_WrapObj@ m_wrapObjx = null;
        float_WrapObj@ Getx_WrapObj()
        {
            if (m_wrapObjx is null)
            {
                @m_wrapObjx = float_WrapObj(float_GetFunction(this.Getfloat_x), "x", m_qualifiedName + ".x");
            }
            return m_wrapObjx;
        }

        private float Getfloat_y()
        {
            auto self = m_getFunctionVec4();
            return self.y;
        }
        private float_WrapObj@ m_wrapObjy = null;
        float_WrapObj@ Gety_WrapObj()
        {
            if (m_wrapObjy is null)
            {
                @m_wrapObjy = float_WrapObj(float_GetFunction(this.Getfloat_y), "y", m_qualifiedName + ".y");
            }
            return m_wrapObjy;
        }

        private float Getfloat_z()
        {
            auto self = m_getFunctionVec4();
            return self.z;
        }
        private float_WrapObj@ m_wrapObjz = null;
        float_WrapObj@ Getz_WrapObj()
        {
            if (m_wrapObjz is null)
            {
                @m_wrapObjz = float_WrapObj(float_GetFunction(this.Getfloat_z), "z", m_qualifiedName + ".z");
            }
            return m_wrapObjz;
        }

        private float Getfloat_w()
        {
            auto self = m_getFunctionVec4();
            return self.w;
        }
        private float_WrapObj@ m_wrapObjw = null;
        float_WrapObj@ Getw_WrapObj()
        {
            if (m_wrapObjw is null)
            {
                @m_wrapObjw = float_WrapObj(float_GetFunction(this.Getfloat_w), "w", m_qualifiedName + ".w");
            }
            return m_wrapObjw;
        }
    }
}
