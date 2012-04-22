// Automatically generated test for Class Rosella.Json.Builder.Factory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Json.Builder.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Json_Builder_Factory
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Json.Builder.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Json.Builder.Factory);
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
    var(Rosella.Test.test)(class Test_Rosella_Json_Builder_Factory, initialize_test:[named("initialize")]);
}
