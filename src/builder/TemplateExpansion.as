
namespace builder
{
    class TemplateExpansion
    {
        TemplateExpansion()
        {
        }

        void Test(const string&in filename)
        {
            IO::FileSource fs(filename);
            string contents = fs.ReadToEnd();

            array<string> bodySegments = {};
            array<string> tokens = {};
            Tokenize(contents, bodySegments, tokens);
            dictionary database = {
                {"name", "this is my message"},
                {"classname", "MyClass234"}
            };
            string test = ProcessVar(bodySegments, tokens, database);
            IO::File of(IO::FromDataFolder("Plugins/NodMonitor/src/autogen/out.txt"), IO::FileMode::Write);
            of.Write(test);
            of.Close();
        }

        // Splits a input string into a series of segments and a series of
        // tokens. Input an empty array for both bodySegments and tokens and
        // it will be filled with the result.
        private void Tokenize(const string&in body, array<string>@ bodySegments, array<string>@ tokens)
        {
            const string TOKEN_BEGIN = "##$";
            const string TOKEN_END = "$##";

            array<string>@ segments = body.Split(TOKEN_END);
            for (uint i = 0; i < segments.Length; i++)
            {
                string bodySegment = segments[i];
                string token = "";
                if (i < segments.Length - 1)
                {
                    array<string>@ splitSegment = segments[i].Split(TOKEN_BEGIN);
                    if (splitSegment.Length != 2)
                    {
                        throw("Bad token format exception: \n" + tostring(segments[i]));
                    }
                    bodySegment = splitSegment[0];
                    token = splitSegment[1];
                }
                bodySegments.InsertLast(bodySegment);
                if (token != "")
                {
                    tokens.InsertLast(token);
                }
            }
        }

        private string ProcessVar(array<string>@ bodySegments, array<string>@ tokens, dictionary@ database)
        {
            string processResult = "";
            for (uint i = 0; i < bodySegments.Length; ++i)
            {
                if (i > 0)
                {
                    string currToken = tokens[i-1];
                    if (currToken.StartsWith("var."))
                    {
                        string name = currToken.SubStr(4);
                        if (database.Exists(name))
                        {
                            string value = string(database[name]);
                            processResult += value;
                        }
                        else
                        {
                            throw("Missing var in database: " + name);
                        }
                    }
                }
                processResult += bodySegments[i];
            }
            return processResult;
        }
    }
}
