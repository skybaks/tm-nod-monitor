
namespace api
{
    funcdef mat4 mat4_GetFunction();
    class mat4_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private mat4_GetFunction@ m_getFunctionMat4;

        mat4_WrapObj(mat4_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionMat4 = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return "mat4";
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
            else if (name == "xz")
            {
                return Getxz_WrapObj();
            }
            else if (name == "xw")
            {
                return Getxw_WrapObj();
            }
            else if (name == "yx")
            {
                return Getyx_WrapObj();
            }
            else if (name == "yy")
            {
                return Getyy_WrapObj();
            }
            else if (name == "yz")
            {
                return Getyz_WrapObj();
            }
            else if (name == "yw")
            {
                return Getyw_WrapObj();
            }
            else if (name == "zx")
            {
                return Getzx_WrapObj();
            }
            else if (name == "zy")
            {
                return Getzy_WrapObj();
            }
            else if (name == "zz")
            {
                return Getzz_WrapObj();
            }
            else if (name == "zw")
            {
                return Getzw_WrapObj();
            }
            else if (name == "tx")
            {
                return Gettx_WrapObj();
            }
            else if (name == "ty")
            {
                return Getty_WrapObj();
            }
            else if (name == "tz")
            {
                return Gettz_WrapObj();
            }
            else if (name == "tw")
            {
                return Gettw_WrapObj();
            }
            return null;
        }

        private float Getfloat_xx()
        {
            auto self = m_getFunctionMat4();
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
            auto self = m_getFunctionMat4();
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

        private float Getfloat_xz()
        {
            auto self = m_getFunctionMat4();
            return self.xz;
        }
        private float_WrapObj@ m_wrapObjxz = null;
        float_WrapObj@ Getxz_WrapObj()
        {
            if (m_wrapObjxz is null)
            {
                @m_wrapObjxz = float_WrapObj(float_GetFunction(this.Getfloat_xz), "xz", m_qualifiedName + ".xz");
            }
            return m_wrapObjxz;
        }

        private float Getfloat_xw()
        {
            auto self = m_getFunctionMat4();
            return self.xw;
        }
        private float_WrapObj@ m_wrapObjxw = null;
        float_WrapObj@ Getxw_WrapObj()
        {
            if (m_wrapObjxw is null)
            {
                @m_wrapObjxw = float_WrapObj(float_GetFunction(this.Getfloat_xw), "xw", m_qualifiedName + ".xw");
            }
            return m_wrapObjxw;
        }

        private float Getfloat_yx()
        {
            auto self = m_getFunctionMat4();
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
            auto self = m_getFunctionMat4();
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

        private float Getfloat_yz()
        {
            auto self = m_getFunctionMat4();
            return self.yz;
        }
        private float_WrapObj@ m_wrapObjyz = null;
        float_WrapObj@ Getyz_WrapObj()
        {
            if (m_wrapObjyz is null)
            {
                @m_wrapObjyz = float_WrapObj(float_GetFunction(this.Getfloat_yz), "yz", m_qualifiedName + ".yz");
            }
            return m_wrapObjyz;
        }

        private float Getfloat_yw()
        {
            auto self = m_getFunctionMat4();
            return self.yw;
        }
        private float_WrapObj@ m_wrapObjyw = null;
        float_WrapObj@ Getyw_WrapObj()
        {
            if (m_wrapObjyw is null)
            {
                @m_wrapObjyw = float_WrapObj(float_GetFunction(this.Getfloat_yw), "yw", m_qualifiedName + ".yw");
            }
            return m_wrapObjyw;
        }

        private float Getfloat_zx()
        {
            auto self = m_getFunctionMat4();
            return self.zx;
        }
        private float_WrapObj@ m_wrapObjzx = null;
        float_WrapObj@ Getzx_WrapObj()
        {
            if (m_wrapObjzx is null)
            {
                @m_wrapObjzx = float_WrapObj(float_GetFunction(this.Getfloat_zx), "zx", m_qualifiedName + ".zx");
            }
            return m_wrapObjzx;
        }

        private float Getfloat_zy()
        {
            auto self = m_getFunctionMat4();
            return self.zy;
        }
        private float_WrapObj@ m_wrapObjzy = null;
        float_WrapObj@ Getzy_WrapObj()
        {
            if (m_wrapObjzy is null)
            {
                @m_wrapObjzy = float_WrapObj(float_GetFunction(this.Getfloat_zy), "zy", m_qualifiedName + ".zy");
            }
            return m_wrapObjzy;
        }

        private float Getfloat_zz()
        {
            auto self = m_getFunctionMat4();
            return self.zz;
        }
        private float_WrapObj@ m_wrapObjzz = null;
        float_WrapObj@ Getzz_WrapObj()
        {
            if (m_wrapObjzz is null)
            {
                @m_wrapObjzz = float_WrapObj(float_GetFunction(this.Getfloat_zz), "zz", m_qualifiedName + ".zz");
            }
            return m_wrapObjzz;
        }

        private float Getfloat_zw()
        {
            auto self = m_getFunctionMat4();
            return self.zw;
        }
        private float_WrapObj@ m_wrapObjzw = null;
        float_WrapObj@ Getzw_WrapObj()
        {
            if (m_wrapObjzw is null)
            {
                @m_wrapObjzw = float_WrapObj(float_GetFunction(this.Getfloat_zw), "zw", m_qualifiedName + ".zw");
            }
            return m_wrapObjzw;
        }

        private float Getfloat_tx()
        {
            auto self = m_getFunctionMat4();
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
            auto self = m_getFunctionMat4();
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

        private float Getfloat_tz()
        {
            auto self = m_getFunctionMat4();
            return self.tz;
        }
        private float_WrapObj@ m_wrapObjtz = null;
        float_WrapObj@ Gettz_WrapObj()
        {
            if (m_wrapObjtz is null)
            {
                @m_wrapObjtz = float_WrapObj(float_GetFunction(this.Getfloat_tz), "tz", m_qualifiedName + ".tz");
            }
            return m_wrapObjtz;
        }

        private float Getfloat_tw()
        {
            auto self = m_getFunctionMat4();
            return self.tw;
        }
        private float_WrapObj@ m_wrapObjtw = null;
        float_WrapObj@ Gettw_WrapObj()
        {
            if (m_wrapObjtw is null)
            {
                @m_wrapObjtw = float_WrapObj(float_GetFunction(this.Getfloat_tw), "tw", m_qualifiedName + ".tw");
            }
            return m_wrapObjtw;
        }
    }
}
