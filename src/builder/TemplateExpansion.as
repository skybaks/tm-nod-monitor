
namespace builder
{
    // Template Syntax
    // ---------------
    // ##$ to begin a directive and $## to end
    // - whitespace is not allowed within a directive
    //
    // -- Variables --
    // ##$var`varname$##
    // In the example above, varname is the name of a field in the input
    // dictionary. The value at that key name will be inserted into the
    // template
    //
    // -- Loops --
    // ##$loop`id`arrayname`localname$##
    // ##$endloop`id$##
    // "id" is a string that matches the loop and endloop as belonging
    // together. The "arrayname" is the key value of an array of dict inside
    // your dictionary. For each iteration of the loop, the element of that
    // array will be copied into a field named with what you put in
    // "localname".
    // Additionally, the following built-in variables will get added to your
    // "localname":
    //  - localname.loop.index
    //  - localname.loop.length
    //  - localname.loop.isFirst
    //  - localname.loop.isLast
    //
    // -- Conditionals --
    // ##$if`id`var`varname`==`literal`literalstring$##
    // ##$elif`id`literal`varname`==`var`literalstring$##
    // ##$else`id$##
    // ##$endif`id$##
    // "id" is a string that matches all the parts of the conditional
    // together. It works just like an if/if else/else in other languages, if
    // one condition is true the rest are skipped. Every comparison is
    // performed as a string comparison.
    // The `var` directive will indicate that the side of the condition should
    // be evaluated as a variable lookup in the data dictionary. The `literal`
    // indicates that the following text should be taken as a literal string.
    // Supported comparisons are `==` and `!=`
    //
    // -- Comments --
    // ##$comment type here$##
    // Anything in the comment directive will be removed from the final
    // template expansion. Use a comment to document the template but leave it
    // out of the result.
    //

    namespace TemplateExpansion
    {
        void Expand(const string&in template, dictionary@ data, MemoryBuffer@ mb)
        {
            array<string> bodySegments = {};
            array<string> tokens = {};
            Private::Tokenize(template, bodySegments, tokens);
            Private::Process(bodySegments, tokens, data, mb);
        }

        namespace Private
        {
            // Splits a input string into a series of segments and a series of
            // tokens. Input an empty array for both bodySegments and tokens and
            // it will be filled with the result.
            void Tokenize(const string&in body, array<string>@ bodySegments, array<string>@ tokens)
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

            void Process(array<string>@ bodySegments, array<string>@ tokens, dictionary@ database, MemoryBuffer@ mb)
            {
                // should do some fancier logic around this. all at once is about 2 seconds
                //yield();

                const string TOKEN_INTERNAL = "`";
                uint tokenIndex = 0;
                while (tokenIndex < tokens.Length)
                {
                    mb.Write(bodySegments[tokenIndex]);

                    if (tokens[tokenIndex].StartsWith("loop"))
                    {
                        array<string>@ loopSplit = tokens[tokenIndex].Split(TOKEN_INTERNAL);
                        string loopId = loopSplit[1];
                        string loopObjName = loopSplit[2];
                        string loopLclName = loopSplit[3];
                        // Jump to next token
                        tokenIndex += 1;
                        // find the end of the loop, then enter a recursion
                        array<string> loopSegments = {};
                        array<string> loopTokens = {};
                        while (tokenIndex < tokens.Length)
                        {
                            loopSegments.InsertLast(bodySegments[tokenIndex]);
                            if (tokens[tokenIndex].StartsWith("endloop"))
                            {
                                array<string>@ endloopSplit = tokens[tokenIndex].Split(TOKEN_INTERNAL);
                                string endloopId = endloopSplit[1];
                                if (loopId == endloopId)
                                {
                                    array<dictionary>@ loopContextArray = cast<array<dictionary>>(GetValue(loopObjName, database));
                                    dictionary loopBuiltin = {
                                        {"index", "0"},
                                        {"length", tostring(loopContextArray.Length)},
                                        {"isFirst", "true"},
                                        {"isLast", "false"}
                                    };
                                    // loop through the loop
                                    for (uint i = 0; i < loopContextArray.Length; ++i)
                                    {
                                        loopBuiltin["index"] = tostring(i);
                                        loopBuiltin["isFirst"] = i == 0 ? "true" : "false";
                                        loopBuiltin["isLast"] = i+1 == loopContextArray.Length ? "true" : "false";
                                        loopContextArray[i]["loop"] = loopBuiltin;

                                        database[loopLclName] = loopContextArray[i];
                                        Process(loopSegments, loopTokens, database, mb);
                                        cast<dictionary>(database[loopLclName]).Delete("loop");
                                        database.Delete(loopLclName);
                                    }
                                    break;
                                }
                            }
                            loopTokens.InsertLast(tokens[tokenIndex]);
                            tokenIndex += 1;
                        }
                    }
                    else if (tokens[tokenIndex].StartsWith("if"))
                    {
                        array<string>@ ifSplit = tokens[tokenIndex].Split(TOKEN_INTERNAL);
                        string ifId = ifSplit[1];
                        string ifObjA_Type = ifSplit[2];
                        string ifObjA_Name = ifSplit[3];
                        string ifCmp = ifSplit[4];
                        string ifObjB_Type = ifSplit[5];
                        string ifObjB_Name = ifSplit[6];
                        // Jump to the next token
                        tokenIndex += 1;
                        // Take one branch at a time until a condition is
                        // satisfied or the matching endif is encountered. If a
                        // condition is taken, all subsequent branches will be
                        // discarded until the endif.
                        bool oneBranchSatisfied = false;
                        bool ifIsTrue = TestCondition(ifObjA_Type, ifObjA_Name, ifObjB_Type, ifObjB_Name, ifCmp, database);
                        array<string> ifSegments = {};
                        array<string> ifTokens = {};
                        while (tokenIndex < tokens.Length)
                        {
                            bool skipToken = false;
                            ifSegments.InsertLast(bodySegments[tokenIndex]);
                            if (tokens[tokenIndex].StartsWith("elif")
                                || tokens[tokenIndex].StartsWith("else")
                                || tokens[tokenIndex].StartsWith("endif"))
                            {
                                array<string>@ otherIfSplit = tokens[tokenIndex].Split(TOKEN_INTERNAL);
                                string otherIfId = otherIfSplit[1];
                                if (ifId == otherIfId)
                                {
                                    // Previous if was true so process it now
                                    if (ifIsTrue)
                                    {
                                        ifIsTrue = false;
                                        oneBranchSatisfied = true;
                                        Process(ifSegments, ifTokens, database, mb);
                                    }
                                    // if is closed so break out now
                                    if (tokens[tokenIndex].StartsWith("endif"))
                                    {
                                        break;
                                    }
                                    // Starting new branch, clear out buffers
                                    ifSegments.RemoveRange(0, ifSegments.Length);
                                    ifTokens.RemoveRange(0, ifTokens.Length);
                                    skipToken = true;
                                    if (tokens[tokenIndex].StartsWith("else") && !oneBranchSatisfied)
                                    {
                                        // No conditions satisfied so run the else
                                        ifIsTrue = true;
                                    }
                                    else if (tokens[tokenIndex].StartsWith("elif") && !oneBranchSatisfied)
                                    {
                                        string elifObjA_Type = otherIfSplit[2];
                                        string elifObjA_Name = otherIfSplit[3];
                                        string elifCmp = otherIfSplit[4];
                                        string elifObjB_Type = otherIfSplit[5];
                                        string elifObjB_Name = otherIfSplit[6];
                                        ifIsTrue = TestCondition(elifObjA_Type, elifObjA_Name, elifObjB_Type, elifObjB_Name, elifCmp, database);
                                    }
                                }
                            }
                            // Need this so that we can jump past this token when
                            // we are starting a new branch of the conditional
                            if (!skipToken)
                            {
                                ifTokens.InsertLast(tokens[tokenIndex]);
                            }
                            tokenIndex += 1;
                        }
                    }
                    else if (tokens[tokenIndex].StartsWith("var"))
                    {
                        array<string>@ varSplit = tokens[tokenIndex].Split(TOKEN_INTERNAL);
                        string varName = varSplit[1];
                        string varValue = string(GetValue(varName, database));
                        mb.Write(varValue);
                    }
                    else if (tokens[tokenIndex].StartsWith("comment"))
                    {
                        // Comment is omitted from processed result, therefore do
                        // nothing
                    }
                    else
                    {
                        throw("Non-op token: " + tokens[tokenIndex]);
                    }
                    tokenIndex += 1;
                }
                mb.Write(bodySegments[tokenIndex]);
            }

            dictionaryValue@ GetValue(const string&in name, dictionary@ database)
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

            // Go through the lines in the result and scrape out the garbage that
            // gets left behind when the tokens get stripped out.
            // This removes any lines that contain whitespace. Lines without
            // whitespace will be retained.
            string CleanupFormat(const string&in body)
            {
                array<string>@ lines = body.Split("\n");
                uint index = 0;
                while (index < lines.Length)
                {
                    if (lines[index].Trim() == "" && lines[index].Length > 1)
                    {
                        lines.RemoveAt(index);
                    }
                    else
                    {
                        index += 1;
                    }
                }
                return string::Join(lines, "\n");
            }

            bool TestCondition(
                const string&in aType, const string&in aName,
                const string&in bType, const string&in bName,
                const string&in cmp,
                dictionary@ database)
            {
                string aValue = aName;
                if (aType == "var")
                {
                    aValue = string(GetValue(aName, database));
                }
                string bValue = bName;
                if (bType == "var")
                {
                    bValue = string(GetValue(bName, database));
                }

                if (cmp == "==")
                {
                    return aValue == bValue;
                }
                else if (cmp == "!=")
                {
                    return aValue != bValue;
                }
                else
                {
                    throw("Unsupported cmp in condition: " + cmp);
                }
                return false;
            }
        }
    }
}
