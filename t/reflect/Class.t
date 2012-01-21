// Automatically generated test for Class Rosella.Reflect.Class
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Reflect.Class(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Reflect_Class
{
    function set_constructor()
    {
        self.status.verify("Test Rosella.Reflect.Class.set_constructor()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.set_constructor(arg_0);
    }

    function name()
    {
        self.status.verify("Test Rosella.Reflect.Class.name()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.name();
    }

    function purge()
    {
        self.status.verify("Test Rosella.Reflect.Class.purge()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.purge();
    }

    function new()
    {
        self.status.verify("Test Rosella.Reflect.Class.new()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.new();
    }

    function get_attr()
    {
        self.status.verify("Test Rosella.Reflect.Class.get_attr()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.get_attr(arg_0);
    }

    function get_attr_value()
    {
        self.status.verify("Test Rosella.Reflect.Class.get_attr_value()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.get_attr_value(arg_0, arg_1);
    }

    function set_attr_value()
    {
        self.status.verify("Test Rosella.Reflect.Class.set_attr_value()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.set_attr_value(arg_0, arg_1, arg_2);
    }

    function invoke_method()
    {
        self.status.verify("Test Rosella.Reflect.Class.invoke_method()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.invoke_method(arg_0, arg_1);
    }

    function isa()
    {
        self.status.verify("Test Rosella.Reflect.Class.isa()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.isa(arg_0);
    }

    function can()
    {
        self.status.verify("Test Rosella.Reflect.Class.can()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.can(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect_Class);
}
