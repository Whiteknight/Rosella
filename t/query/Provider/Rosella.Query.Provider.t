// Automatically generated test for NameSpace Rosella.Query.Provider
class Test_Rosella_Query_Provider
{
    function get_array_provider()
    {
        self.status.verify("Test Rosella.Query.Provider.get_array_provider()");
        using Rosella.Query.Provider.get_array_provider;

        var result = get_array_provider();
        self.assert.instance_of(result, class Rosella.Query.Provider.Array);
    }

    function get_hash_provider()
    {
        self.status.verify("Test Rosella.Query.Provider.get_hash_provider()");
        using Rosella.Query.Provider.get_hash_provider;

        var result = get_hash_provider();
        self.assert.instance_of(result, class Rosella.Query.Provider.Hash);
    }

    function get_scalar_provider()
    {
        self.status.verify("Test Rosella.Query.Provider.get_scalar_provider()");
        using Rosella.Query.Provider.get_scalar_provider;

        var result = get_scalar_provider();
        self.assert.instance_of(result, class Rosella.Query.Provider.Scalar);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Provider);
}
