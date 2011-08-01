class Test_Rosella_Template_Handler_Set
{
    function test_new() {
        var obj = new Rosella.Template.Handler.Set([
            "foo"
        ]);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Set);
    }

    function test_new_2_FAIL() {
        self.assert.throws(function() {
            var obj = new Rosella.Template.Handler.Set([
                "foo",
                "bar"
            ]);
        });
    }

    function test_new_3() {
        var obj = new Rosella.Template.Handler.Set([
            "foo",
            "as",
            "bar"
        ]);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Set);
    }

    function test_new_3_FAIL() {
        self.assert.throws(function() {
            var obj = new Rosella.Template.Handler.Set([
                "foo",
                "WRONG",
                "bar"
            ]);
        });
    }

    function can_have_children_1() {
        self.status.verify("Test Rosella.Template.Handler.Set.can_have_children(1)");
        var obj = new Rosella.Template.Handler.Set([
            "foo"
        ]);

        var result = obj.can_have_children();
        self.assert.is_true(result);
    }

    function can_have_children_3() {
        self.status.verify("Test Rosella.Template.Handler.Set.can_have_children(3)");
        var obj = new Rosella.Template.Handler.Set([
            "foo",
            "as",
            "bar"
        ]);

        var result = obj.can_have_children();
        self.assert.is_false(result);
    }

    function add_child_3() {
        self.status.verify("Test Rosella.Template.Handler.Set.add_child(3)");
        var obj = new Rosella.Template.Handler.Set([
            "foo",
            "as",
            "bar"
        ]);

        var arg_0 = null;
        self.assert.throws(function() {
            var result = obj.add_child(arg_0);
        });
    }

    function add_child_1_FAIL() {
        self.status.verify("Test Rosella.Template.Handler.Set.add_child(1)");
        var obj = new Rosella.Template.Handler.Set([
            "foo"
        ]);

        self.assert.throws(function() {
            var arg_0 = null;
            var result = obj.add_child(arg_0);
        });
    }

    function render_3() {
        self.status.verify("Test Rosella.Template.Handler.Set.render()");
        var obj = new Rosella.Template.Handler.Set([
            "foo",
            "as",
            "bar"
        ]);

        var arg_0 = null;
        var arg_1 = new Rosella.Template.Context({"foo" : "a", "bar" : "b"});
        var arg_2 = new "StringBuilder";
        var result = obj.render(arg_0, arg_1, arg_2);
        self.assert.equal(string(arg_2), "");
        self.assert.equal(arg_1["foo"], "b");
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Handler_Set);
}
