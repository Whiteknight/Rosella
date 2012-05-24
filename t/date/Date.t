// Automatically generated test for Class Rosella.Date
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    if (elements(p_args) == 0)
        return Rosella.Date.now();
    return new Rosella.Date(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Date
{
    function copy()
    {
        self.status.verify("Test Rosella.Date.copy()");
        var obj = create_new();

        var result = obj.clone();
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(obj, result);
        self.assert.equal(obj, result);
    }

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
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        int arg_0 = 5;
        var result = obj.add_minutes(arg_0);
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(result, obj);
        self.assert.equal(result.minutes(), 18);
    }

    function hours()
    {
        self.status.verify("Test Rosella.Date.hours()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        int result = obj.hours();
        self.assert.equal(result, 10);
    }

    function add_hours()
    {
        self.status.verify("Test Rosella.Date.add_hours()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var arg_0 = 5;
        var result = obj.add_hours(arg_0);
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(result, obj);
        self.assert.equal(result.hours(), 15);
    }

    function day()
    {
        self.status.verify("Test Rosella.Date.day()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        int result = obj.day();
        self.assert.equal(result, 4);
    }

    function add_days()
    {
        self.status.verify("Test Rosella.Date.add_days()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var arg_0 = 5;
        var result = obj.add_days(arg_0);
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(result, obj);
        self.assert.equal(result.day(), 9);
    }

    function week_day()
    {
        self.status.verify("Test Rosella.Date.week_day()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        int result = obj.week_day();
        self.assert.equal(result, 0);
    }

    function week_day_name()
    {
        self.status.verify("Test Rosella.Date.week_day_name()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var result = obj.week_day_name();
        self.assert.equal(result, "Sunday");
    }

    function month()
    {
        self.status.verify("Test Rosella.Date.month()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        int result = obj.month();
        self.assert.equal(result, 3);
    }

    function add_months()
    {
        self.status.verify("Test Rosella.Date.add_months()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var arg_0 = 5;
        var result = obj.add_months(arg_0);
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(result, obj);
        self.assert.equal(result.month(), 8);
    }

    function month_name()
    {
        self.status.verify("Test Rosella.Date.month_name()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        string result = obj.month_name();
        self.assert.equal(result, "March");
    }

    function year()
    {
        self.status.verify("Test Rosella.Date.year()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        int result = obj.year();
        self.assert.equal(result, 2012);
    }

    function add_years()
    {
        self.status.verify("Test Rosella.Date.add_years()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var arg_0 = 5;
        var result = obj.add_years(arg_0);
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(result, obj);
        self.assert.equal(result.year(), 2017);
    }

    function raw_time()
    {
        self.status.verify("Test Rosella.Date.raw_time()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var result = obj.raw_time();
        self.assert.equal(result, -1);

        obj = create_new();
        result = obj.raw_time();
        self.assert.instance_of(result, 'Integer');
    }

    function date()
    {
        self.status.verify("Test Rosella.Date.date()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var result = obj.date();
    }

    function time()
    {
        self.status.verify("Test Rosella.Date.time()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var result = obj.time();
    }

    function format_string()
    {
        self.status.verify("Test Rosella.Date.format_string()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);

        var arg_0 = "{yyyy} {MM} {dd} {hh} {mm} {ss}";
        string result = obj.format_string(arg_0);
        self.assert.equal(result, "2012 03 04 10 13 10");
    }

    function get_string_formatter()
    {
        self.status.verify("Test Rosella.Date.get_string_formatter()");
        var obj = create_new();

        var result = obj.get_string_formatter();
        self.assert.instance_of(result, class Rosella.Date.DateFormatter);
    }

    function clone()
    {
        self.status.verify("Test Rosella.Date.clone()");
        var obj = create_new();

        var result = obj.clone();
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.not_same(obj, result);
        self.assert.equal(obj, result);
    }

    function get_string()
    {
        self.status.verify("Test Rosella.Date.get_string()");
        var obj = create_new();

        string result = obj.get_string();
        self.assert.equal(length(result), 19);
    }

    function equals()
    {
        self.status.verify("Test Rosella.Date.equals()");
        var obj = create_new();

        var arg_0 = obj.add_seconds(5);
        int result = obj.equals(arg_0);
        self.assert.is_false(result);

        arg_0 = obj;
        result = obj.equals(arg_0);
        self.assert.is_true(result);
    }

    function compare_to()
    {
        self.status.verify("Test Rosella.Date.compare_to()");
        var obj = create_new();

        var arg_0 = obj.add_seconds(50);
        int result = obj.cmp(arg_0);
        self.assert.equal(result, -1);

        arg_0 = obj;
        result = obj.cmp(arg_0);
        self.assert.equal(result, 0);

        arg_0 = obj.add_seconds(-50);
        result = obj.cmp(arg_0);
        self.assert.equal(result, 1);
    }

    function add_span()
    {
        self.status.verify("Test Rosella.Date.add()");
        var obj = create_new(2012, 03, 04, 10, 13, 10);
        var arg_0 = new Rosella.Date.TimeSpan(1, 2, 3, 4);
        var result = obj.add_span(arg_0);
        self.assert.instance_of(result, class Rosella.Date);
        self.assert.equal(result.seconds(), 14);
        self.assert.equal(result.minutes(), 16);
        self.assert.equal(result.hours(), 12);
        self.assert.equal(result.day(), 5);
    }

    function diff()
    {
        self.status.verify("Test Rosella.Date.subtract()");
        var arg_0 = create_new(2012, 03, 04, 10, 13, 10);
        var obj = arg_0.add_seconds(400);
        var result = obj.diff(arg_0);
        self.assert.instance_of(result, class Rosella.Date.TimeSpan);
        self.assert.equal(result.seconds(), 40);
        self.assert.equal(result.minutes(), 6);
        self.assert.equal(result.hours(), 0);
        self.assert.equal(result.days(), 0);
    }

    function diff2() {
        var a = new Rosella.Date(2012, 04, 9,  1, 0, 0);
        var b = new Rosella.Date(2012, 04, 10, 0, 0, 0);
        var ts = b.diff(a);
        self.assert.equal(ts.days(), 0);
        self.assert.equal(ts.hours(), 23);
    }

    function diff3() {
        var a = new Rosella.Date(2012, 04, 9,  0, 0, 0);
        var b = new Rosella.Date(2012, 04, 10, 1, 0, 0);
        var ts = b.diff(a);
        self.assert.equal(ts.days(), 1);
        self.assert.equal(ts.hours(), 1);
    }

    function day_of_year() {
        var a = new Rosella.Date(2012, 05, 24,  0, 0, 0);
        int d = a.day_of_year();
        self.assert.equal(d, 144);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/date.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Date);
}
