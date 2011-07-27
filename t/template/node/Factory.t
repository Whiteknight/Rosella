// Automatically generated test for Class Rosella.Template.Node.Factory
class Test_Rosella_Template_Node_Factory
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Node.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Factory);
    }


    function Factory() {
        self.status.verify("Test Rosella.Template.Node.Factory.Factory()");
        var obj = new Rosella.Template.Node.Factory();

        var result = obj.Factory();
    }

    function register_type() {
        self.status.verify("Test Rosella.Template.Node.Factory.register_type()");
        var obj = new Rosella.Template.Node.Factory();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.register_type(arg_0, arg_1);
    }

    function create() {
        self.status.verify("Test Rosella.Template.Node.Factory.create()");
        var obj = new Rosella.Template.Node.Factory();

        var arg_0 = null;
        var result = obj.create(arg_0);
    }

    function create_typed() {
        self.status.verify("Test Rosella.Template.Node.Factory.create_typed()");
        var obj = new Rosella.Template.Node.Factory();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.create_typed(arg_0, arg_1);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Factory);
}
