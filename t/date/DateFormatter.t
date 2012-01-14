// Automatically generated test for Class Rosella.Date.DateFormatter
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Date.DateFormatter(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Date_DateFormatter
{
    function format()
    {
        self.status.verify("Test Rosella.Date.DateFormatter.format()");
        var obj = create_new();

        var arg_0 = new Rosella.Date(2012, 1, 14, 7, 23, 44);
        string arg_1 = "yyyy MM dd hh mm ss";
        string result = obj.format(arg_0, arg_1);
        self.assert.equal(result, "2012 01 14 07 23 44");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/date.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Date_DateFormatter);
}
