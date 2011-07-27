// Automatically generated test for Class Rosella.Template.Node.Eval
class Test_Rosella_Template_Node_Eval
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Node.Eval();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Eval);
    }


    function Eval() {
        self.status.verify("Test Rosella.Template.Node.Eval.Eval()");
        var obj = new Rosella.Template.Node.Eval();

        var arg_0 = null;
        var result = obj.Eval(arg_0);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Eval.render()");
        var obj = new Rosella.Template.Node.Eval();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.render(arg_0, arg_1, arg_2);
    }

    function compile_func() {
        self.status.verify("Test Rosella.Template.Node.Eval.compile_func()");
        var obj = new Rosella.Template.Node.Eval();

        var arg_0 = null;
        var result = obj.compile_func(arg_0);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Eval);
}
