
namespace api
{
    interface IWatchTableObject
    {
        string get_Name();
        string get_FullName();
        string get_Value();
        IWatchTableObject@ GetMember(const string&in name);
    }
}
