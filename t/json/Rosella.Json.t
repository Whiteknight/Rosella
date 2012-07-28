// Automatically generated test for NameSpace Rosella.Json
class Test_Rosella_Json
{
    function to_json()
    {
        self.status.verify("Test Rosella.Json.to_json()");
        self.status.unimplemented("Find a good way to test this");
        using Rosella.Json.to_json;

        var arg_0 = null;
        var result = to_json(arg_0);
    }

    function parse()
    {
        self.status.verify("Test Rosella.Json.parse()");
        using Rosella.Json.parse;

        string arg_0 = "{'foo' : 1, 'bar' : 2, 'baz' : 3, 'fie': [4, 5, true, false, null]}";
        var result = parse(arg_0).get_value();
        self.assert.equal(elements(result), 4);
        self.assert.equal(result["foo"], 1);
        self.assert.equal(result["bar"], 2);
        self.assert.equal(result["baz"], 3);
        self.assert.equal(result["fie"][0], 4);
        self.assert.equal(result["fie"][1], 5);
        self.assert.equal(result["fie"][2], true);
        self.assert.equal(result["fie"][3], false);
        self.assert.is_null(result["fie"][4]);
    }

    function parse_simple()
    {
        self.status.verify("Test Rosella.Json.parse()");
        using Rosella.Json.parse_simple;

        string arg_0 = "{'foo' : 1, 'bar' : 2, 'baz' : 3, 'fie': [4, 5, true, false, null]}";
        var result = parse_simple(arg_0);
        self.assert.equal(elements(result), 4);
        self.assert.equal(result["foo"], 1);
        self.assert.equal(result["bar"], 2);
        self.assert.equal(result["baz"], 3);
        self.assert.equal(result["fie"][0], 4);
        self.assert.equal(result["fie"][1], 5);
        self.assert.equal(result["fie"][2], true);
        self.assert.equal(result["fie"][3], false);
        self.assert.is_null(result["fie"][4]);
    }

    function default_builder_factory()
    {
        self.status.verify("Test Rosella.Json.default_builder_factory()");
        using Rosella.Json.default_builder_factory;
        var result = default_builder_factory();
        self.assert.not_null(result);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Initialize the context, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/json.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Json, initialize_test:[named("initialize")]);
}
