// Automatically generated test for Class Rosella.Template.Node.Logic
class Test_Rosella_Template_Node_Logic
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Node.Logic();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Logic);
    }


    function Logic() {
        self.status.verify("Test Rosella.Template.Node.Logic.Logic()");
        var obj = new Rosella.Template.Node.Logic();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.Logic(arg_0, arg_1);
    }

    function parse() {
        self.status.verify("Test Rosella.Template.Node.Logic.parse()");
        var obj = new Rosella.Template.Node.Logic();

        var arg_0 = null;
        var result = obj.parse(arg_0);
    }

    function logic_name() {
        self.status.verify("Test Rosella.Template.Node.Logic.logic_name()");
        var obj = new Rosella.Template.Node.Logic();

        var result = obj.logic_name();
    }

    function logic_end_name() {
        self.status.verify("Test Rosella.Template.Node.Logic.logic_end_name()");
        var obj = new Rosella.Template.Node.Logic();

        var result = obj.logic_end_name();
    }

    function assemble() {
        self.status.verify("Test Rosella.Template.Node.Logic.assemble()");
        var obj = new Rosella.Template.Node.Logic();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.assemble(arg_0, arg_1);
    }

    function is_logic_end() {
        self.status.verify("Test Rosella.Template.Node.Logic.is_logic_end()");
        var obj = new Rosella.Template.Node.Logic();

        var result = obj.is_logic_end();
    }

    function add_child() {
        self.status.verify("Test Rosella.Template.Node.Logic.add_child()");
        var obj = new Rosella.Template.Node.Logic();

        var arg_0 = null;
        var result = obj.add_child(arg_0);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Logic.render()");
        var obj = new Rosella.Template.Node.Logic();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.render(arg_0, arg_1, arg_2);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Logic);
}
