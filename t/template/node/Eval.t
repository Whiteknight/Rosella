class Test_Rosella_Template_Node_Eval
{
    function test_new() {
        var obj = new Rosella.Template.Node.Eval("foo", "bar");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Eval);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Eval.render()");
        self.status.unimplemented("Test this");
        var obj = new Rosella.Template.Node.Eval("return 5;");

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = new 'StringBuilder';
        obj.render(arg_0, arg_1, arg_2);
        self.assert.equal(string(arg_2), "5");
    }

    function compile_func() {
        self.status.verify("Test Rosella.Template.Node.Eval.compile_func()");
        self.status.unimplemented("Test this");
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
