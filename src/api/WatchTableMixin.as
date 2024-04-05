
namespace api
{
    mixin class WatchTableMixin
    {
        protected string m_name;
        protected string m_qualifiedName;

        string get_Name() { return m_name; }
        string get_FullName() { return m_qualifiedName; }
    }
}
