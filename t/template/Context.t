class Test_Rosella_Template_Context
{
    function test_new() {
        var obj = new Rosella.Template.Context({});
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Context);
    }

    function set_temporary() {
        self.status.verify("Test Rosella.Template.Context.set_temporary()");
        var obj = new Rosella.Template.Context({});

        var arg_0 = "foo";
        var arg_1 = "bar";
        obj.set_temporary(arg_0, arg_1);
        self.assert.equal(obj["foo"], "bar");
    }

    function get_value_user_data() {
        self.status.verify("Test Rosella.Template.Context.get_value()");
        var obj = new Rosella.Template.Context({"foo" : "bar"});

        var arg_0 = "foo";
        var result = obj.get_value(arg_0);
        self.assert.equal(result, "bar");
    }

    function get_value_temporary() {
        self.status.verify("Test Rosella.Template.Context.get_value()");
        var obj = new Rosella.Template.Context({});
        obj.set_temporary("foo", "bar");
        var arg_0 = "foo";
        var result = obj.get_value(arg_0);
        self.assert.equal(result, "bar");
    }

    function get_value_temporary_override() {
        self.status.verify("Test Rosella.Template.Context.get_value()");
        var obj = new Rosella.Template.Context({"foo" : "bar"});
        obj.set_temporary("foo", "baz");
        var arg_0 = "foo";
        var result = obj.get_value(arg_0);
        self.assert.equal(result, "baz");
    }

    function get_value_fail() {
        self.status.verify("Test Rosella.Template.Context.get_value()");
        var obj = new Rosella.Template.Context({});

        var arg_0 = "foo";
        var result = obj.get_value(arg_0);
        self.assert.is_null(result);
    }

    function set_pmc_keyed() {
        self.status.verify("Test Rosella.Template.Context.set_pmc_keyed()");
        var obj = new Rosella.Template.Context({});

        var arg_0 = "foo";
        var arg_1 = "bar";
        obj.set_pmc_keyed(arg_0, arg_1);
    }

    function get_pmc_keyed() {
        self.status.verify("Test Rosella.Template.Context.get_pmc_keyed()");
        var obj = new Rosella.Template.Context({"foo":"bar"});

        var arg_0 = "foo";
        var result = obj.get_pmc_keyed(arg_0);
        self.assert.equal(result, "bar");
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Context);
}
