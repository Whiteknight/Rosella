// Automatically generated test for Class Rosella.Container.Option.Property
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Container.Option.Property(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Container_Option_Property
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Container.Option.Property();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Container.Option.Property);
    }


    function Property()
    {
        self.status.verify("Test Rosella.Container.Option.Property.Property()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.Property(arg_0, arg_1);
    }

    function execute()
    {
        self.status.verify("Test Rosella.Container.Option.Property.execute()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.execute(arg_0, arg_1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Option_Property);
}
