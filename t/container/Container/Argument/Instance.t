// Automatically generated test for Class Rosella.Container.Argument.Instance
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Container.Argument.Instance(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Container_Argument_Instance
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Container.Argument.Instance();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Container.Argument.Instance);
    }


    function Instance()
    {
        self.status.verify("Test Rosella.Container.Argument.Instance.Instance()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.Instance(arg_0);
    }

    function get_value()
    {
        self.status.verify("Test Rosella.Container.Argument.Instance.get_value()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.get_value(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Argument_Instance);
}
