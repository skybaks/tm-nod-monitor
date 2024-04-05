
namespace api
{
    funcdef iso3 iso3_GetFunction();
    class iso3_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private iso3_GetFunction@ m_getFunctionIso3;

        iso3_WrapObj(iso3_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionIso3 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return "iso3";
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            if (name == "xx")
            {
                return Getxx_WrapObj();
            }
            else if (name == "xy")
            {
                return Getxy_WrapObj();
            }
            else if (name == "yx")
            {
                return Getyx_WrapObj();
            }
            else if (name == "yy")
            {
                return Getyy_WrapObj();
            }
            else if (name == "tx")
            {
                return Gettx_WrapObj();
            }
            else if (name == "ty")
            {
                return Getty_WrapObj();
            }
            return null;
        }

        private float Getfloat_xx()
        {
            auto self = m_getFunctionIso3();
            return self.xx;
        }
        private float_WrapObj@ m_wrapObjxx = null;
        float_WrapObj@ Getxx_WrapObj()
        {
            if (m_wrapObjxx is null)
            {
                @m_wrapObjxx = float_WrapObj(float_GetFunction(this.Getfloat_xx), "xx", m_qualifiedName + ".xx");
            }
            return m_wrapObjxx;
        }

        private float Getfloat_xy()
        {
            auto self = m_getFunctionIso3();
            return self.xy;
        }
        private float_WrapObj@ m_wrapObjxy = null;
        float_WrapObj@ Getxy_WrapObj()
        {
            if (m_wrapObjxy is null)
            {
                @m_wrapObjxy = float_WrapObj(float_GetFunction(this.Getfloat_xy), "xy", m_qualifiedName + ".xy");
            }
            return m_wrapObjxy;
        }

        private float Getfloat_yx()
        {
            auto self = m_getFunctionIso3();
            return self.yx;
        }
        private float_WrapObj@ m_wrapObjyx = null;
        float_WrapObj@ Getyx_WrapObj()
        {
            if (m_wrapObjyx is null)
            {
                @m_wrapObjyx = float_WrapObj(float_GetFunction(this.Getfloat_yx), "yx", m_qualifiedName + ".yx");
            }
            return m_wrapObjyx;
        }

        private float Getfloat_yy()
        {
            auto self = m_getFunctionIso3();
            return self.yy;
        }
        private float_WrapObj@ m_wrapObjyy = null;
        float_WrapObj@ Getyy_WrapObj()
        {
            if (m_wrapObjyy is null)
            {
                @m_wrapObjyy = float_WrapObj(float_GetFunction(this.Getfloat_yy), "yy", m_qualifiedName + ".yy");
            }
            return m_wrapObjyy;
        }

        private float Getfloat_tx()
        {
            auto self = m_getFunctionIso3();
            return self.tx;
        }
        private float_WrapObj@ m_wrapObjtx = null;
        float_WrapObj@ Gettx_WrapObj()
        {
            if (m_wrapObjtx is null)
            {
                @m_wrapObjtx = float_WrapObj(float_GetFunction(this.Getfloat_tx), "tx", m_qualifiedName + ".tx");
            }
            return m_wrapObjtx;
        }

        private float Getfloat_ty()
        {
            auto self = m_getFunctionIso3();
            return self.ty;
        }
        private float_WrapObj@ m_wrapObjty = null;
        float_WrapObj@ Getty_WrapObj()
        {
            if (m_wrapObjty is null)
            {
                @m_wrapObjty = float_WrapObj(float_GetFunction(this.Getfloat_ty), "ty", m_qualifiedName + ".ty");
            }
            return m_wrapObjty;
        }
    }
}
