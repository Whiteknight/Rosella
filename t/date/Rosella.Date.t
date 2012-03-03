// Automatically generated test for NameSpace Rosella.Date
class Test_Rosella_Date
{
    function get_day_of_week()
    {
        self.status.verify("Test Rosella.Date.get_day_of_week()");
        using Rosella.Date.get_day_of_week;

        int arg_0 = 2012;
        int arg_1 = 1;
        int arg_2 = 14;
        int result = get_day_of_week(arg_0, arg_1, arg_2);
        self.assert.equal(result, 6);
    }

    function get_day_of_week_name()
    {
        self.status.verify("Test Rosella.Date.get_day_of_week_name()");
        using Rosella.Date.get_day_of_week_name;

        int arg_0 = 2012;
        int arg_1 = 1;
        int arg_2 = 14;
        string result = get_day_of_week_name(arg_0, arg_1, arg_2);
        self.assert.equal(result, "Saturday");
    }

    function get_day_of_week_name()
    {
        self.status.verify("Test Rosella.Date.get_day_of_week_name()");
        using Rosella.Date.get_day_of_week_name;

        int arg_0 = 6;
        string result = get_day_of_week_name(6);
        self.assert.equal(result, "Saturday");
    }

    function now()
    {
        self.status.verify("Test Rosella.Date.now()");
        using Rosella.Date.now;
        var result = now();
        self.assert.instance_of(result, class Rosella.Date);
    }

    function min()
    {
        self.status.verify("Test Rosella.Date.min()");
        using Rosella.Date.min;
        var result = min();
        self.assert.instance_of(result, class Rosella.Date.SpecialDate.Minimum);
    }

    function max()
    {
        self.status.verify("Test Rosella.Date.max()");
        using Rosella.Date.max;
        var result = max();
        self.assert.instance_of(result, class Rosella.Date.SpecialDate.Maximum);
    }

    function all_months()
    {
        self.status.verify("Test Rosella.Date.all_months()");
        using Rosella.Date.all_months;
        var result = all_months();
        self.assert.equal(elements(result), 12);
        self.assert.equal(result[0], "January");
        self.assert.equal(result[11], "December");
    }

    function all_months_short()
    {
        self.status.verify("Test Rosella.Date.all_months_short()");
        using Rosella.Date.all_months_short;
        var result = all_months_short();
        self.assert.equal(elements(result), 12);
        self.assert.equal(result[0], "Jan");
        self.assert.equal(result[11], "Dec");
    }

    function all_week_days()
    {
        self.status.verify("Test Rosella.Date.all_week_days()");
        using Rosella.Date.all_week_days;
        var result = all_week_days();
        self.assert.equal(elements(result), 7);
        self.assert.equal(result[0], "Sunday");
        self.assert.equal(result[6], "Saturday");
    }

    function month_day_counts()
    {
        self.status.verify("Test Rosella.Date.month_day_counts()");
        using Rosella.Date.month_day_counts;

        int arg_0 = 2012;
        var result = month_day_counts(arg_0);
        self.assert.equal(result[0], 31);
        self.assert.equal(result[1], 29);

        arg_0 = 2011;
        result = month_day_counts(arg_0);
        self.assert.equal(result[0], 31);
        self.assert.equal(result[1], 28);
    }

    function is_leap_year()
    {
        self.status.verify("Test Rosella.Date.is_leap_year()");
        using Rosella.Date.is_leap_year;

        int arg_0 = 2012;
        int result = is_leap_year(arg_0);
        self.assert.is_true(result);

        arg_0 = 2011;
        result = is_leap_year(arg_0);
        self.assert.is_false(result);

        arg_0 = 2000;
        result = is_leap_year(arg_0);
        self.assert.is_true(result);

        arg_0 = 2100;
        result = is_leap_year(arg_0);
        self.assert.is_false(result);
    }

    function default_date_formatter()
    {
        self.status.verify("Test Rosella.Date.default_date_formatter()");
        using Rosella.Date.default_date_formatter;
        var result = default_date_formatter();
        self.assert.instance_of(result, class Rosella.Date.DateFormatter);
    }

    function default_timespan_formatter()
    {
        self.status.verify("Test Rosella.Date.default_timespan_formatter()");
        using Rosella.Date.default_timespan_formatter;
        var result = default_timespan_formatter();
        self.assert.instance_of(result, class Rosella.Date.TimeSpanFormatter);
    }

    function default_day_calculator()
    {
        self.status.verify("Test Rosella.Date.default_day_calculator()");
        using Rosella.Date.default_day_calculator;
        var result = default_day_calculator();
        self.assert.instance_of(result, class Rosella.Date.Doomsday);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/date.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Date);
}
