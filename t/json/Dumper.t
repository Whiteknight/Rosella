// Automatically generated test for Class Rosella.Json.Dumper
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Json.Dumper(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Json_Dumper
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Json.Dumper();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Json.Dumper);
    }

    function default_role_dumpers()
    {
        self.status.verify("Test Rosella.Json.Dumper.default_role_dumpers()");
        var obj = create_new();

        var result = obj.default_role_dumpers();
    }

    function default_misc_dumpers()
    {
        self.status.verify("Test Rosella.Json.Dumper.default_misc_dumpers()");
        var obj = create_new();

        var result = obj.default_misc_dumpers();
    }

    function default_type_dumpers()
    {
        self.status.verify("Test Rosella.Json.Dumper.default_type_dumpers()");
        var obj = create_new();

        var result = obj.default_type_dumpers();
    }

    function default_fallback_dumper()
    {
        self.status.verify("Test Rosella.Json.Dumper.default_fallback_dumper()");
        var obj = create_new();

        var result = obj.default_fallback_dumper();
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/json.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Json_Dumper, initialize_test:[named("initialize")]);
}
