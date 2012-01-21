// Automatically generated test for Class Rosella.Reflect.Module
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Reflect.Module(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Reflect_Module
{
    function load()
    {
        self.status.verify("Test Rosella.Reflect.Module.load()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.load();
    }

    function init()
    {
        self.status.verify("Test Rosella.Reflect.Module.init()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.init();
    }

    function path()
    {
        self.status.verify("Test Rosella.Reflect.Module.path()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.path();
    }

    function get_string()
    {
        self.status.verify("Test Rosella.Reflect.Module.get_string()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.get_string();
    }

    function version()
    {
        self.status.verify("Test Rosella.Reflect.Module.version()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.version();
    }

    function classes()
    {
        self.status.verify("Test Rosella.Reflect.Module.classes()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.classes();
    }

    function functions()
    {
        self.status.verify("Test Rosella.Reflect.Module.functions()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.functions();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect_Module);
}
