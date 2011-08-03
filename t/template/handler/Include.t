class Test_Rosella_Template_Handler_Include
{
    function test_new() {
        var obj = new Rosella.Template.Handler.Include(["foo.txt"]);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Include);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Handler.Include.render()");
        var obj = new Rosella.Template.Handler.Include(["foo.txt"]);

        self.status.todo("Figure out a way to test this");
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
    test(class Test_Rosella_Template_Handler_Include);
}
