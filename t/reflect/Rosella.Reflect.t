// Automatically generated test for NameSpace Rosella.Reflect
class Test_Rosella_Reflect
{
    function get_current_module()
    {
        self.status.verify("Test Rosella.Reflect.get_current_module()");
        self.status.unimplemented("TODO");
        using Rosella.Reflect.get_current_module;
        var result = get_current_module();
    }

    function get_current_sub()
    {
        self.status.verify("Test Rosella.Reflect.get_current_sub()");
        self.status.unimplemented("TODO");
        using Rosella.Reflect.get_current_sub;
        var result = get_current_sub();
    }

    function get_current_context()
    {
        self.status.verify("Test Rosella.Reflect.get_current_context()");
        self.status.unimplemented("TODO");
        using Rosella.Reflect.get_current_context;
        var result = get_current_context();
    }

    function get_current_object()
    {
        self.status.verify("Test Rosella.Reflect.get_current_object()");
        self.status.unimplemented("TODO");
        using Rosella.Reflect.get_current_object;
        var result = get_current_object();
    }

    function get_current_class()
    {
        self.status.verify("Test Rosella.Reflect.get_current_class()");
        self.status.unimplemented("TODO");
        using Rosella.Reflect.get_current_class;
        var result = get_current_class();
    }

    function get_class_reflector()
    {
        self.status.verify("Test Rosella.Reflect.get_class_reflector()");
        self.status.unimplemented("TODO");
        using Rosella.Reflect.get_class_reflector;

        var arg_0 = null;
        var result = get_class_reflector(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect);
}
