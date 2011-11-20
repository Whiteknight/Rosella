// Automatically generated test for Class Rosella.Container.Resolver
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Container.Resolver(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Container_Resolver
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Container.Resolver();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Container.Resolver);
    }


    function previous()
    {
        self.status.verify("Test Rosella.Container.Resolver.previous()");
        var obj = create_new();

        var result = obj.previous();
    }

    function set_options()
    {
        self.status.verify("Test Rosella.Container.Resolver.set_options()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.set_options(arg_0);
    }

    function resolve()
    {
        self.status.verify("Test Rosella.Container.Resolver.resolve()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.resolve(arg_0, arg_1);
    }

    function execute_options()
    {
        self.status.verify("Test Rosella.Container.Resolver.execute_options()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.execute_options(arg_0, arg_1, arg_2);
    }

    function get_arguments()
    {
        self.status.verify("Test Rosella.Container.Resolver.get_arguments()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.get_arguments(arg_0, arg_1, arg_2);
    }

    function resolve_internal()
    {
        self.status.verify("Test Rosella.Container.Resolver.resolve_internal()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.resolve_internal(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver);
}
