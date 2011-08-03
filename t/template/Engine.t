class Test_Rosella_Template_Engine
{
    function test_new() {
        var obj = new Rosella.Template.Engine();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Engine);
    }

    function Engine() {
        self.status.verify("Test Rosella.Template.Engine.Engine()");
        var obj = new Rosella.Template.Engine();

        var result = obj.Engine();
    }

    function setup_default_regions() {
        self.status.verify("Test Rosella.Template.Engine.setup_default_regions()");
        var obj = new Rosella.Template.Engine();

        var result = obj.setup_default_regions();
        self.assert.does(result, "hash");
    }

    function setup_region_types() {
        self.status.verify("Test Rosella.Template.Engine.setup_region_types()");
        var obj = new Rosella.Template.Engine();

        var mockfactory = new Rosella.MockObject.Factory();
        var tc = mockfactory.create_typed(class Rosella.String.Tokenizer.DelimiterRegion);
        tc.expect_method("add_region").once().with_args("<%", "%>", "Eval");
        tc.expect_method("add_region").once().with_args("<#", "#>", "Data");
        tc.expect_method("add_region").once().with_args("<$", "$>", "Logic");

        var nfc = mockfactory.create_typed(class Rosella.Template.Node.Factory);
        nfc.expect_method("register_type").once().with_args("!!!LiteralRegion!!!", class Rosella.Template.Node.Literal);
        nfc.expect_method("register_type").once().with_args("Eval", class Rosella.Template.Node.Eval);
        nfc.expect_method("register_type").once().with_args("Data", class Rosella.Template.Node.Data);
        nfc.expect_method("register_type").once().with_any_args();
        // TODO: Need general matching capabilities for the third argument/

        var arg_0 = tc.mock();
        var arg_1 = nfc.mock();
        obj.setup_region_types(arg_0, arg_1);
        tc.verify();
        nfc.verify();
    }

    function add_region() {
        self.status.verify("Test Rosella.Template.Engine.add_region()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = "foo";
        var arg_1 = "<!--";
        var arg_2 = "-->";
        var arg_3 = "class";
        obj.add_region(arg_0, arg_1, arg_2, arg_3);
    }

    function remove_region() {
        self.status.verify("Test Rosella.Template.Engine.remove_region()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = "Eval";
        obj.remove_region(arg_0);
    }

    function set_region_delimiters() {
        self.status.verify("Test Rosella.Template.Engine.set_region_delimiters()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = "Data";
        var arg_1 = "{%";
        var arg_2 = "%}";
        obj.set_region_delimiters(arg_0, arg_1, arg_2);
    }

    function set_region_delimiters_fail() {
        self.status.verify("Test Rosella.Template.Engine.set_region_delimiters()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = "Foo";
        var arg_1 = "{%";
        var arg_2 = "%}";
        self.assert.throws(function() {
            obj.set_region_delimiters(arg_0, arg_1, arg_2);
        });
    }

    function set_region_nodeclass() {
        self.status.verify("Test Rosella.Template.Engine.set_region_nodeclass()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = "Logic";
        var arg_1 = "class";
        obj.set_region_nodeclass(arg_0, arg_1);
    }

    function set_region_nodeclass_fail() {
        self.status.verify("Test Rosella.Template.Engine.set_region_nodeclass()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = "Foo";
        var arg_1 = "class";
        self.assert.throws(function() {
            obj.set_region_nodeclass(arg_0, arg_1);
        });
    }

    function generate() {
        self.status.verify("Test Rosella.Template.Engine.generate()");
        var obj = new Rosella.Template.Engine();

        self.status.unimplemented("Need to mock up items");
        var arg_0 = null;
        var arg_1 = null;
        var result = obj.generate(arg_0, arg_1);
    }

    function generate_from_file() {
        self.status.verify("Test Rosella.Template.Engine.generate_from_file()");
        var obj = new Rosella.Template.Engine();

        self.status.unimplemented("Need to mock up items");
        var arg_0 = null;
        var arg_1 = null;
        var result = obj.generate_from_file(arg_0, arg_1);
    }

    function __get_context_object() {
        self.status.verify("Test Rosella.Template.Engine.__get_context_object()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = {};
        var result = obj.__get_context_object(arg_0);
        self.assert.instance_of(result, class Rosella.Template.Context);
    }

    function __get_context_object_same() {
        self.status.verify("Test Rosella.Template.Engine.__get_context_object()");
        var obj = new Rosella.Template.Engine();

        var arg_0 = new Rosella.Template.Context({});
        var result = obj.__get_context_object(arg_0);
        self.assert.same(result, arg_0);
    }

    function __get_nodes_array() {
        self.status.verify("Test Rosella.Template.Engine.__get_nodes_array()");
        var obj = new Rosella.Template.Engine();

        self.status.unimplemented("Figure out a way to test this");
        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.__get_nodes_array(arg_0, arg_1, arg_2);
    }

    function __create_node_tree() {
        self.status.verify("Test Rosella.Template.Engine.__create_node_tree()");
        var obj = new Rosella.Template.Engine();

        self.status.unimplemented("Figure out a way to test this");
        var arg_0 = null;
        var result = obj.__create_node_tree(arg_0);
    }

    function __get_template_from_file() {
        self.status.verify("Test Rosella.Template.Engine.__get_template_from_file()");
        var obj = new Rosella.Template.Engine();
        using Rosella.Template.get_standard_template_file;
        var arg_0 = get_standard_template_file("test_class.winxed.template");
        var result = obj.__get_template_from_file(arg_0);
        self.assert.not_equal(length(result), 0);
    }

    function __get_template_from_file_fail() {
        self.status.verify("Test Rosella.Template.Engine.__get_template_from_file()");
        var obj = new Rosella.Template.Engine();
        var arg_0 = "does not exist";
        self.assert.throws(function() {
            var result = obj.__get_template_from_file(arg_0);
        });
    }

    function __generate_internal() {
        self.status.verify("Test Rosella.Template.Engine.__generate_internal()");
        var obj = new Rosella.Template.Engine();

        self.status.unimplemented("Figure out a way to test this. Probably need mocks");
        var arg_0 = null;
        var arg_1 = null;
        var result = obj.__generate_internal(arg_0, arg_1);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/mockobject.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Engine);
}
