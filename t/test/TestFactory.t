INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::TestFactory::Test);

class MyTestCaseSubclass is Rosella::Test::TestCase {
}

class Test::TestFactory::Test {
    method test_BUILD() {
        my $factory := Rosella::construct(Rosella::Test::TestFactory, {});
    }

    method test_create_TestCase() {
        my %options := {};
        %options{"testcase_type"} := Rosella::Test::TestCase;
        my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase);
        my $testcase := $factory.create("Foo", "Bar");
        $!assert.instance_of($testcase, Rosella::Test::TestCase);
    }

    method test_create_custom_subclass() {
        my $factory := Rosella::construct(Rosella::Test::TestFactory, MyTestCaseSubclass);
        my $testcase := $factory.create("Foo", "Bar");
        $!assert.instance_of($testcase, MyTestCaseSubclass);
    }

    method test_create_typed_TestCase() {
        my %options := {};
        %options{"testcase_type"} := Rosella::Test::TestCase;
        my $factory := Rosella::construct(Rosella::Test::TestFactory, %options);
        my $testcase := $factory.create_typed(Rosella::Test::TestCase, "Foo", "Bar");
        $!assert.instance_of($testcase, Rosella::Test::TestCase);
    }

    method test_create_typed_custom_subclass() {
        my %options := {};
        %options{"testcase_type"} := Rosella::Test::TestCase;
        my $factory := Rosella::construct(Rosella::Test::TestFactory, %options);
        my $testcase := $factory.create_typed(MyTestCaseSubclass, "Foo", "Bar");
        $!assert.instance_of($testcase, MyTestCaseSubclass);
    }
}
