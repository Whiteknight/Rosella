// Automatically generated test for Class Rosella.Template.Handler.Factory
class Test_Rosella_Template_Handler_Factory
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Handler.Factory({});
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Factory);
    }

    function create() {
        self.status.verify("Test Rosella.Template.Handler.Factory.create()");
        var obj = new Rosella.Template.Handler.Factory({
            "Foo": class Rosella.Template.Handler.Children
        });

        var arg_0 = "Foo";
        var arg_1 = [];
        var result = obj.create(arg_0, arg_1);
        self.assert.instance_of(result, class Rosella.Template.Handler.Children);
    }

    function create_FAIL() {
        self.status.verify("Test Rosella.Template.Handler.Factory.create(invalid)");
        var obj = new Rosella.Template.Handler.Factory({
            "Foo": class Rosella.Template.Handler.Childless
        });

        var arg_0 = "Bar";
        var arg_1 = [];
        self.assert.throws(function() {
            var result = obj.create(arg_0, arg_1);
        });
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Handler_Factory);
}
