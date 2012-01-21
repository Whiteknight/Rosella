// Automatically generated test for Class Rosella.Reflect.Class.Attribute
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Reflect.Class.Attribute(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Reflect_Class_Attribute
{
    function get_value()
    {
        self.status.verify("Test Rosella.Reflect.Class.Attribute.get_value()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.get_value(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect_Class_Attribute);
}
