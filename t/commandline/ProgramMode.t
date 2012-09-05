function setup_arguments(var defs, var raw_args)
{
    var arg_defs = Rosella.CommandLine.ArgumentDef.get_argument_definition(defs);
    var args = new Rosella.CommandLine.Arguments(null);
    args.parse(raw_args, arg_defs);
    return args;
}

// Automatically generated test for Class Rosella.CommandLine.ProgramMode
class Test_Rosella_CommandLine_ProgramMode
{
    function set_function()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.set_function()");
        var obj = new Rosella.CommandLine.ProgramMode("");

        var arg_0 = function(var args) { };
        obj.set_function(arg_0);
    }

    function set_usage()
    {
        // TODO: This is very fragile, I don't like matching exact strings, especially
        // when there's whitespace involved.
        var obj = new Rosella.CommandLine.ProgramMode("foo");
        obj.set_usage("This is a test");
        string usage = obj.get_usage("foo");
        self.assert.str_equal(usage, "       foo This is a test\n");
    }

    function get_usage()
    {
        self.status.unimplemented("Need to set up some conditions to test with");
    }

    function can_accept()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.can_accept()");
        var obj = new Rosella.CommandLine.ProgramMode("");

        var arg_0 = null;
        var result = obj.can_accept(arg_0);
    }

    function main_function()
    {
        self.status.verify("Test Rosella.CommandLine.ProgramMode.main_function()");
        var obj = new Rosella.CommandLine.ProgramMode("");

        // If we haven't set a function, this should throw an exception
        self.assert.throws(function() {
            var result = obj.main_function();
        });

        var arg_0 = function(var args) { };
        obj.set_function(arg_0);
        var result = obj.main_function();
        self.assert.same(result, arg_0);
    }

    function require_flag()
    {
        var obj = new Rosella.CommandLine.ProgramMode("");
        var args = setup_arguments({"foo":"foo","bar":"bar"}, ["--foo"]);
        obj.require_flag("foo");
        int result = obj.can_accept(args);
        self.assert.is_true(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo":"foo", "bar":"bar"}, ["--bar"]);
        obj.require_flag("foo");
        result = obj.can_accept(args);
        self.assert.is_false(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo":"foo", "bar":"bar"}, ["--bar", "--foo"]);
        obj.require_flag("foo");
        result = obj.can_accept(args);
        self.assert.is_true(result);
    }

    function require_value()
    {
        var obj = new Rosella.CommandLine.ProgramMode("");
        var args = setup_arguments({"foo=s":"foo","bar=s":"bar"}, ["--foo:baz"]);
        obj.require_value("foo", "baz");
        int result = obj.can_accept(args);
        self.assert.is_true(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo=s":"foo", "bar=s":"bar"}, ["--foo:fie"]);
        obj.require_value("foo", "baz");
        result = obj.can_accept(args);
        self.assert.is_false(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo=s":"foo", "bar=s":"bar"}, ["--bar:baz"]);
        obj.require_value("foo", "baz");
        result = obj.can_accept(args);
        self.assert.is_false(result);
    }

    function require_condition()
    {
        self.status.unimplemented("This");
    }

    function require_scalar()
    {
        var obj = new Rosella.CommandLine.ProgramMode("");
        var args = setup_arguments({"foo=s":"foo","bar=s":"bar"}, ["--foo:baz"]);
        obj.require_scalar("foo");
        int result = obj.can_accept(args);
        self.assert.is_true(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo=s":"foo", "bar=s":"bar"}, ["--bar:fie"]);
        obj.require_scalar("foo");
        result = obj.can_accept(args);
        self.assert.is_false(result);
    }

    function require_positionals()
    {
        var obj = new Rosella.CommandLine.ProgramMode("");
        var args = setup_arguments({"foo=s0":"foo","bar=s1":"bar"}, ["AAA", "BBB"]);
        obj.require_positionals(2);
        int result = obj.can_accept(args);
        self.assert.is_true(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo=s0":"foo","bar=s1":"bar"}, ["AAA", "BBB"]);
        obj.require_positionals(2, 2);
        result = obj.can_accept(args);
        self.assert.is_true(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo=s0":"foo","bar=s1":"bar"}, ["AAA"]);
        obj.require_positionals(2);
        result = obj.can_accept(args);
        self.assert.is_false(result);

        obj = new Rosella.CommandLine.ProgramMode("");
        args = setup_arguments({"foo=s0":"foo","bar=s1":"bar"}, ["AAA", "BBB", "CCC"]);
        obj.require_positionals(2, 2);
        result = obj.can_accept(args);
        self.assert.is_false(result);

    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    using Rosella.initialize_rosella; initialize_rosella("test");
    using Rosella.load_bytecode_file; load_bytecode_file("rosella/commandline.pbc", "load");
    using Rosella.Test.test;          test(class Test_Rosella_CommandLine_ProgramMode);
}
