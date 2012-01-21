// Automatically generated test for Class Rosella.Reflect.Class.Member
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Reflect.Class.Member(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Reflect_Class_Member
{
    function class_obj()
    {
        self.status.verify("Test Rosella.Reflect.Class.Member.class_obj()");
        var obj = create_new(class Test_Rosella_Reflect_Class_Member);

        var result = obj.class_obj();
        self.assert.instance_of(result, 'Class');
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect_Class_Member);
}
