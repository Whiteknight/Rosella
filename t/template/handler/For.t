// Automatically generated test for Class Rosella.Template.Handler.For
class Test_Rosella_Template_Handler_For
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Handler.For();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.For);
    }


    function For() {
        self.status.verify("Test Rosella.Template.Handler.For.For()");
        var obj = new Rosella.Template.Handler.For();

        var arg_0 = null;
        var result = obj.For(arg_0);
    }

    function add_child() {
        self.status.verify("Test Rosella.Template.Handler.For.add_child()");
        var obj = new Rosella.Template.Handler.For();

        var arg_0 = null;
        var result = obj.add_child(arg_0);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Handler.For.render()");
        var obj = new Rosella.Template.Handler.For();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.render(arg_0, arg_1, arg_2);
    }

    function __render_hash() {
        self.status.verify("Test Rosella.Template.Handler.For.__render_hash()");
        var obj = new Rosella.Template.Handler.For();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = obj.__render_hash(arg_0, arg_1, arg_2, arg_3);
    }

    function __render_array() {
        self.status.verify("Test Rosella.Template.Handler.For.__render_array()");
        var obj = new Rosella.Template.Handler.For();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = obj.__render_array(arg_0, arg_1, arg_2, arg_3);
    }

    function __render_scalar() {
        self.status.verify("Test Rosella.Template.Handler.For.__render_scalar()");
        var obj = new Rosella.Template.Handler.For();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = obj.__render_scalar(arg_0, arg_1, arg_2, arg_3);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Handler_For);
}
