
namespace builder
{
    // var$varname
    // loop$id$arrayname$localname
    // endloop$id
    // if$id
    // elif$id
    // else$id
    // endif$id

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
                {"classname", "MyClass234"},
                {"options", array<dictionary> = {
                    {{"opt1", "asdf"}},
                    {{"opt1", "wwww"}},
                    {{"opt1", "peep"}},
                    {{"opt1", "qooq"}}
                }},
                {"dict_test", dictionary = {{"t1", ":)"}, {"t2", "1234"}}}
            };
            string test = Process(bodySegments, tokens, database);
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

        private string Process(array<string>@ bodySegments, array<string>@ tokens, dictionary@ database)
        {
            string processResult = "";
            array<string> workSegments = {};
            array<string> workTokens = {};
            uint tokenIndex = 0;
            while (tokenIndex < tokens.Length)
            {
                processResult += bodySegments[tokenIndex];

                if (tokens[tokenIndex].StartsWith("loop"))
                {
                    array<string>@ loopSplit = tokens[tokenIndex].Split("$");
                    string loopId = loopSplit[1];
                    string loopObjName = loopSplit[2];
                    string loopLclName = loopSplit[3];
                    // Jump to next token
                    tokenIndex += 1;
                    // find the end of the loop, then enter a recursion
                    while (tokenIndex < tokens.Length)
                    {
                        workSegments.InsertLast(bodySegments[tokenIndex]);
                        if (tokens[tokenIndex].StartsWith("endloop"))
                        {
                            array<string>@ endloopSplit = tokens[tokenIndex].Split("$");
                            string endloopId = endloopSplit[1];
                            if (loopId == endloopId)
                            {
                                array<dictionary>@ loopContextArray = cast<array<dictionary>>(GetValue(loopObjName, database));

                                for (uint i = 0; i < loopContextArray.Length; ++i)
                                {
                                    database[loopLclName] = loopContextArray[i];
                                    processResult += Process(workSegments, workTokens, database);
                                    database.Delete(loopLclName);
                                }
                                workSegments.RemoveRange(0, workSegments.Length);
                                workTokens.RemoveRange(0, workTokens.Length);
                                break;
                            }
                        }
                        workTokens.InsertLast(tokens[tokenIndex]);
                        tokenIndex += 1;
                    }
                }
                else if (tokens[tokenIndex].StartsWith("if"))
                {
                    print("entered if");
                }
                else if (tokens[tokenIndex].StartsWith("var"))
                {
                    array<string>@ varSplit = tokens[tokenIndex].Split("$");
                    string varName = varSplit[1];
                    string varValue = string(GetValue(varName, database));
                    processResult += varValue;
                }
                tokenIndex += 1;
            }
            processResult += bodySegments[tokenIndex];

            return processResult;
        }

        private dictionaryValue@ GetValue(const string&in name, dictionary@ database)
        {
            array<string>@ nameSplit = name.Split(".");
            dictionaryValue@ value = null;
            for (uint i = 0; i < nameSplit.Length; ++i)
            {
                // First loop pull from database
                if (i == 0)
                {
                    if (database.Exists(nameSplit[i]))
                    {
                        @value = database[nameSplit[i]];
                    }
                    else
                    {
                        break;
                    }
                }
                else
                {
                    dictionary@ dictValue = cast<dictionary>(value);
                    if (dictValue !is null && dictValue.Exists(nameSplit[i]))
                    {
                        @value = dictValue[nameSplit[i]];
                    }
                    else
                    {
                        break;
                    }
                }
            }
            return value;
        }
    }
}
