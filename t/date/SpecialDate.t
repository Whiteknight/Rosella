// Automatically generated test for Class Rosella.Date.SpecialDate
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Date.SpecialDate.Minimum(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Date_SpecialDate
{
    function add_seconds()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.add_seconds()");
        var obj = create_new();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_seconds(arg_0);
        });
    }

    function add_minutes()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.add_minutes()");
        var obj = create_new();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_minutes(arg_0);
        });
    }

    function add_hours()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.add_hours()");
        var obj = create_new();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_hours(arg_0);
        });
    }

    function add_days()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.add_days()");
        var obj = create_new();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_days(arg_0);
        });
    }

    function add_months()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.add_months()");
        var obj = create_new();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_months(arg_0);
        });
    }

    function add_years()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.add_years()");
        var obj = create_new();

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_years(arg_0);
        });
    }

    function week_day()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.week_day()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.week_day();
        });
    }

    function week_day_name()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.week_day_name()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.week_day_name();
        });
    }

    function date()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.date()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.date();
        });
    }

    function time()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.time()");
        var obj = create_new();

        self.assert.throws(function() {
            var result = obj.time();
        });
    }

    function name()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.name()");
        var obj = create_new();

        string result = obj.name();
    }

    function is_equal()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.is_equal()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.is_equal(arg_0);
    }

    function cmp()
    {
        self.status.verify("Test Rosella.Date.SpecialDate.cmp()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.cmp(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/date.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Date_SpecialDate);
}
