
namespace api
{
    funcdef RGBAColor RGBAColor_GetFunction();
    class RGBAColor_WrapObj : WatchTableMixin, IWatchTableObject
    {
        private RGBAColor_GetFunction@ m_getFunctionRGBAColor;

        RGBAColor_WrapObj(RGBAColor_GetFunction@ getFunction, const string&in name, const string&in qualifiedName)
        {
            @m_getFunctionRGBAColor = getFunction;
            m_name = name;
            m_qualifiedName = qualifiedName;
        }

        string get_Value() override
        {
            return "RGBAColor";
        }

        IWatchTableObject@ GetMember(const string&in name) override
        {
            if (name == "r")
            {
                return Getr_WrapObj();
            }
            else if (name == "g")
            {
                return Getg_WrapObj();
            }
            else if (name == "b")
            {
                return Getb_WrapObj();
            }
            else if (name == "a")
            {
                return Geta_WrapObj();
            }
            else if (name == "rgba")
            {
                return Getrgba_WrapObj();
            }
            return null;
        }

        private uint8 Getuint8_r()
        {
            auto self = m_getFunctionRGBAColor();
            return self.r;
        }
        private uint8_WrapObj@ m_wrapObjr = null;
        uint8_WrapObj@ Getr_WrapObj()
        {
            if (m_wrapObjr is null)
            {
                @m_wrapObjr = uint8_WrapObj(uint8_GetFunction(this.Getuint8_r), "r", m_qualifiedName + ".r");
            }
            return m_wrapObjr;
        }

        private uint8 Getuint8_g()
        {
            auto self = m_getFunctionRGBAColor();
            return self.g;
        }
        private uint8_WrapObj@ m_wrapObjg = null;
        uint8_WrapObj@ Getg_WrapObj()
        {
            if (m_wrapObjg is null)
            {
                @m_wrapObjg = uint8_WrapObj(uint8_GetFunction(this.Getuint8_g), "g", m_qualifiedName + ".g");
            }
            return m_wrapObjg;
        }

        private uint8 Getuint8_b()
        {
            auto self = m_getFunctionRGBAColor();
            return self.b;
        }
        private uint8_WrapObj@ m_wrapObjb = null;
        uint8_WrapObj@ Getb_WrapObj()
        {
            if (m_wrapObjb is null)
            {
                @m_wrapObjb = uint8_WrapObj(uint8_GetFunction(this.Getuint8_b), "b", m_qualifiedName + ".b");
            }
            return m_wrapObjb;
        }

        private uint8 Getuint8_a()
        {
            auto self = m_getFunctionRGBAColor();
            return self.a;
        }
        private uint8_WrapObj@ m_wrapObja = null;
        uint8_WrapObj@ Geta_WrapObj()
        {
            if (m_wrapObja is null)
            {
                @m_wrapObja = uint8_WrapObj(uint8_GetFunction(this.Getuint8_a), "a", m_qualifiedName + ".a");
            }
            return m_wrapObja;
        }

        private uint Getuint_rgba()
        {
            auto self = m_getFunctionRGBAColor();
            return self.rgba;
        }
        private uint_WrapObj@ m_wrapObjrgba = null;
        uint_WrapObj@ Getrgba_WrapObj()
        {
            if (m_wrapObjrgba is null)
            {
                @m_wrapObjrgba = uint_WrapObj(uint_GetFunction(this.Getuint_rgba), "rgba", m_qualifiedName + ".rgba");
            }
            return m_wrapObjrgba;
        }
    }
}
