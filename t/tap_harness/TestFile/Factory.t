INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/harness.pbc");
}

Rosella::Test::test(Harness::TestFile::Factory::Test);

class Harness::TestFile::Factory::Test {
    method test_BUILD() {
        my $factory := Rosella::construct(Rosella::Harness::TestFile::Factory, Rosella::Harness::TestFile);
        $!assert.instance_of($factory, Rosella::Harness::TestFile::Factory);
    }

    method test_create() {
        my $factory := Rosella::construct(Rosella::Harness::TestFile::Factory, Rosella::Harness::TestFile);
        my $testfile := $factory.create("Foo.t");
        $!assert.instance_of($testfile, Rosella::Harness::TestFile);
    }

    method test_create_subclass() {
        my $factory := Rosella::construct(Rosella::Harness::TestFile::Factory, Rosella::Harness::TestFile::Winxed);
        my $testfile := $factory.create("Foo.t");
        $!assert.instance_of($testfile, Rosella::Harness::TestFile::Winxed);
    }

    method test_create_typed() {
        my $factory := Rosella::construct(Rosella::Harness::TestFile::Factory, Rosella::Harness::TestFile);
        my $testfile := $factory.create_typed(Rosella::Harness::TestFile, "Foo.t");
        $!assert.instance_of($testfile, Rosella::Harness::TestFile);
    }

    method test_create_typed_subclass() {
        my $factory := Rosella::construct(Rosella::Harness::TestFile::Factory, Rosella::Harness::TestFile);
        my $testfile := $factory.create_typed(Rosella::Harness::TestFile::NQP, "Foo.t");
        $!assert.instance_of($testfile, Rosella::Harness::TestFile::NQP);
    }

    method test_create_tests_from_dirs() {
        $!status.unimplemented("Find a way to test this");
    }

    method test_create_tests_from_files() {
        $!status.unimplemented("Test this");
    }

    method get_dir_contents() {
        $!status.unimplemented("Test this");
    }

    method is_test() {
        $!status.unimplemented("Test this");
    }
}
