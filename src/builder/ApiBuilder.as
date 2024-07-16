
namespace builder
{
    class ApiBuilder
    {
        private string m_apiFile;
        private string m_apiTemplate;

        ApiBuilder(const string&in apiFile, const string&in apiTemplate)
        {
            m_apiFile = apiFile;
            m_apiTemplate = apiTemplate;
        }

        uint64 get_ApiFileLength()
        {
            IO::FileSource apiFile(PluginPath::SelfPath + m_apiFile);
            return apiFile.Size();
        }

        string get_ApiTemplate()
        {
            IO::FileSource template(m_apiTemplate);
            return template.ReadToEnd();
        }

        void Build()
        {
            if (!PluginPath::IsFolder)
            {
                warn("Skip interface autogen, plugin is not a Folder");
                return;
            }
            dictionary@ data = ParseOpenplanetNextJson();
            print("doing template");
            print("writing output");
            MemoryBuffer mb();
            TemplateExpansion::Expand(ApiTemplate, data, mb);
            print("returned from template");
            IO::File outFile(PluginPath::SelfPath + m_apiFile, IO::FileMode::Write);
            outFile.Write(mb);
            outFile.Close();
            print("done");

            // Get len of existing NodApi file
            // Generate new API file
            //  - make the data dictionary
            //  - process the template(s?)
            // Compare old and new NodApi len's
            //  - should display a warning or smth to user? maybe disable functionality?
        }

        dictionary@ ParseOpenplanetNextJson()
        {
            dictionary data = {};
            Json::Value@ nextJson = Json::FromFile(IO::FromDataFolder("OpenplanetNext.json"));
            // TODO: fill this in, then prune out the cruft
            array<string> referencedTypes = {};
            array<dictionary>@ nextTypes = {};
            Json::Value@ namespacesJson = nextJson["ns"];
            array<string> namespaceKeys = namespacesJson.GetKeys();
            for (uint nsIndex = 0; nsIndex < namespaceKeys.Length; ++nsIndex)
            {
                Json::Value@ nsJson = namespacesJson[namespaceKeys[nsIndex]];
                array<string> typeKeys = nsJson.GetKeys();
                for (uint typeIndex = 0; typeIndex < typeKeys.Length; ++typeIndex)
                {
                    dictionary@ newType = {};
                    newType["name"] = typeKeys[typeIndex];

                    array<string> typeIgnoreList = { "CFastString", "GmNat3", "GmQuat", "IntRange", "RealRange", "GmVec4", "Nat8", "Int16", "GxRGBAColor", "GmInt3", "GmInt2", "Nat16", "GmIso4", "NatRange", "GmVec2", "Enum16", "Int", "Int8", "Nat", "CMwId", "GmIso3", "Bool", "Enum8", "CFastStringInt", "Vec3Color", "GmNat2", "Enum32", "Real", "GmVec3", "UnnamedType", "UnknownType" };
                    if (typeIgnoreList.Find(string(newType["name"])) >= 0)
                    {
                        continue;
                    }

                    Json::Value@ typeJson = nsJson[typeKeys[typeIndex]];
                    newType["parent"] = "";
                    if (typeJson.HasKey("p"))
                    {
                        newType["parent"] = string(typeJson["p"]);

                        // Parents ignore list
                        array<string> parentIgnoreList = { "_0x0A020000" };
                        if (parentIgnoreList.Find(string(newType["parent"])) >= 0)
                        {
                            newType["parent"] = "";
                        }
                    }
                    array<dictionary>@ members = {};
                    if (typeJson.HasKey("m"))
                    {
                        Json::Value@ membersJson = typeJson["m"];
                        for (uint memberIndex = 0; memberIndex < membersJson.Length; ++memberIndex)
                        {
                            Json::Value@ memberJson = membersJson[memberIndex];
                            if (memberJson.HasKey("n")
                                && memberJson.HasKey("t")
                                && memberJson["t"].GetType() == Json::Type::String)
                            {
                                dictionary newMember = {};
                                string memberType = memberJson["t"];
                                string memberName = memberJson["n"];
                                string memberTypeClean = memberType;
                                newMember["name"] = memberName;
                                if (memberTypeClean.EndsWith("@"))
                                {
                                    memberTypeClean = memberTypeClean.SubStr(0, memberTypeClean.Length-1);
                                }
                                // Dont add member if we already have one with the same name
                                bool foundExisting = false;
                                for (uint searchIndex = 0; searchIndex < members.Length; ++searchIndex)
                                {
                                    if (string(members[searchIndex]["name"]) == memberName)
                                    {
                                        foundExisting = true;
                                        break;
                                    }
                                }
                                // Member ignore list
                                if (typeIgnoreList.Find(memberTypeClean) >= 0
                                    || foundExisting)
                                {
                                    continue;
                                }
                                referencedTypes.InsertLast(memberTypeClean);
                                newMember["type"] = memberType;
                                newMember["typeClean"] = memberTypeClean;
                                // TODO: Add array support. Needs updates to template
                                if ((memberType.Contains("<") || memberType.Contains(">"))
                                    // TODO: Add enum support. Needs updates to template
                                    || memberJson.HasKey("e"))
                                {
                                    continue;
                                }
                                members.InsertLast(newMember);
                            }
                        }
                    }
                    newType["members"] = members;
                    nextTypes.InsertLast(newType);
                }
            }
            data["types"] = nextTypes;
            return data;
        }
    }
}
