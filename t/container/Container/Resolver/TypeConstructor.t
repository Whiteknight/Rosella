// Automatically generated test for Class Rosella.Container.Resolver.TypeConstructor
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Container.Resolver.TypeConstructor(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Container_Resolver_TypeConstructor
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Container.Resolver.TypeConstructor();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Container.Resolver.TypeConstructor);
    }


    function TypeConstructor()
    {
        self.status.verify("Test Rosella.Container.Resolver.TypeConstructor.TypeConstructor()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.TypeConstructor(arg_0, arg_1);
    }

    function resolve_internal()
    {
        self.status.verify("Test Rosella.Container.Resolver.TypeConstructor.resolve_internal()");
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
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver_TypeConstructor);
}
