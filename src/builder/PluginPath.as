
namespace builder
{
    namespace PluginPath
    {
        string get_SelfPath()
        {
            if (IsFolder)
            {
                return Meta::ExecutingPlugin().SourcePath;
            }
            return "";
        }

        bool get_IsFolder()
        {
            return Meta::ExecutingPlugin().Type == Meta::PluginType::Folder;
        }
    }
}
