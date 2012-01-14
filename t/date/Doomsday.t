// Automatically generated test for Class Rosella.Date.Doomsday
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Date.Doomsday(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Date_Doomsday
{
    function get_day()
    {
        self.status.verify("Test Rosella.Date.Doomsday.get_day()");
        var obj = create_new();

        int arg_0 = 2012;
        int arg_1 = 1;
        int arg_2 = 14;
        int result = obj.get_day(arg_0, arg_1, arg_2);
        self.assert.equal(result, 6);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/date.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Date_Doomsday);
}
