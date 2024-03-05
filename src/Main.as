
void Main()
{
    auto@ b = builder::ApiBuilder("src/autogen/NodApi.as.txt", "src/builder/NodApi.as.template");
    b.Build();
}
