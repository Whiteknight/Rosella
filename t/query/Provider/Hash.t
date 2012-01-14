// Automatically generated test for Class Rosella.Query.Provider.Hash
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Provider.Hash(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Provider_Hash
{
    function name()
    {
        self.status.verify("Test Rosella.Query.Provider.Hash.name()");
        var obj = create_new();

        string result = obj.name();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Provider_Hash);
}
