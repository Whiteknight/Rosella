// Automatically generated test for Class Rosella.Template.Node.Master
class Test_Rosella_Template_Node_Master
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Node.Master();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Master);
    }


    function Master() {
        self.status.verify("Test Rosella.Template.Node.Master.Master()");
        var obj = new Rosella.Template.Node.Master();

        var result = obj.Master();
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Master.render()");
        var obj = new Rosella.Template.Node.Master();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.render(arg_0, arg_1, arg_2);
    }

    function add_child() {
        self.status.verify("Test Rosella.Template.Node.Master.add_child()");
        var obj = new Rosella.Template.Node.Master();

        var arg_0 = null;
        var result = obj.add_child(arg_0);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Master);
}
