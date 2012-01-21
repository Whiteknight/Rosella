// Automatically generated test for Class Rosella.Date
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Date(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Date
{
    function seconds()
    {
        self.status.verify("Test Rosella.Date.seconds()");
        var obj = create_new(2012, 1, 21);

        int result = obj.seconds();
        self.assert.equal(result, 0);

        obj = create_new(2012, 1, 21, 6, 28, 45);

        result = obj.seconds();
        self.assert.equal(result, 45);
    }

    function add_seconds()
    {
        self.status.verify("Test Rosella.Date.add_seconds()");
        var obj = create_new(2012, 1, 21, 6, 28, 45);

        int arg_0 = 5;
        var result = obj.add_seconds(arg_0);
        self.assert.equal(result.seconds(), 50);

        arg_0 = 15;
        result = obj.add_seconds(arg_0);
        self.assert.equal(result.seconds(), 0);
        self.assert.equal(result.minutes(), 29);
    }

    function minutes()
    {
        self.status.verify("Test Rosella.Date.minutes()");
        var obj = create_new(2012, 1, 21);

        int result = obj.minutes();
        self.assert.equal(result, 0);

        obj = create_new(2012, 1, 21, 6, 28, 45);

        result = obj.minutes();
        self.assert.equal(result, 28);
    }

    function add_minutes()
    {
        self.status.verify("Test Rosella.Date.add_minutes()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.add_minutes(arg_0);
    }

    function hours()
    {
        self.status.verify("Test Rosella.Date.hours()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.hours();
    }

    function add_hours()
    {
        self.status.verify("Test Rosella.Date.add_hours()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.add_hours(arg_0);
    }

    function day()
    {
        self.status.verify("Test Rosella.Date.day()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.day();
    }

    function add_days()
    {
        self.status.verify("Test Rosella.Date.add_days()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.add_days(arg_0);
    }

    function week_day()
    {
        self.status.verify("Test Rosella.Date.week_day()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.week_day();
    }

    function week_day_name()
    {
        self.status.verify("Test Rosella.Date.week_day_name()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.week_day_name();
    }

    function month()
    {
        self.status.verify("Test Rosella.Date.month()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.month();
    }

    function add_months()
    {
        self.status.verify("Test Rosella.Date.add_months()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.add_months(arg_0);
    }

    function month_name()
    {
        self.status.verify("Test Rosella.Date.month_name()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.month_name();
    }

    function year()
    {
        self.status.verify("Test Rosella.Date.year()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.year();
    }

    function add_years()
    {
        self.status.verify("Test Rosella.Date.add_years()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.add_years(arg_0);
    }

    function raw_time()
    {
        self.status.verify("Test Rosella.Date.raw_time()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.raw_time();
    }

    function date()
    {
        self.status.verify("Test Rosella.Date.date()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.date();
    }

    function time()
    {
        self.status.verify("Test Rosella.Date.time()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.time();
    }

    function format_string()
    {
        self.status.verify("Test Rosella.Date.format_string()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.format_string(arg_0);
    }

    function get_string_converter()
    {
        self.status.verify("Test Rosella.Date.get_string_converter()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.get_string_converter();
    }

    function clone()
    {
        self.status.verify("Test Rosella.Date.clone()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.clone();
    }

    function get_string()
    {
        self.status.verify("Test Rosella.Date.get_string()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.get_string();
    }

    function is_equal()
    {
        self.status.verify("Test Rosella.Date.is_equal()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.is_equal(arg_0);
    }

    function cmp()
    {
        self.status.verify("Test Rosella.Date.cmp()");
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
    var(Rosella.Test.test)(class Test_Rosella_Date);
}
