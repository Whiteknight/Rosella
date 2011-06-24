INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::File);

class TestObjectFactory {
    has $!value;
    method __set_return($v) { $!value := $v; }
    method create() { $!value; }
}

class Test::FileSystem::File {
    sub test_with_filehandle_mock($status, &setup, &test) {
        my $c := Rosella::construct(Rosella::MockObject::Factory).create_typed("FileHandle");
        &setup($c);
        my $factory := TestObjectFactory.new();
        Rosella::FileSystem::File::set_filehandle_factory($factory);
        $factory.__set_return($c.mock);
        $status.add_cleanup_routine({
            $factory := Rosella::construct(Rosella::ObjectFactory, "FileHandle");
            Rosella::FileSystem::File::set_filehandle_factory($factory);
        });
        &test();
        $c.verify();
    }

    sub test_with_mock_os($status, &setup, &test) {
        my $c := Rosella::construct(Rosella::MockObject::Factory).create_typed("OS");
        &setup($c);
        my $old_os := Rosella::FileSystem::get_os_pmc();
        Rosella::FileSystem::set_os_pmc($c.mock);
        $status.add_cleanup_routine({
            Rosella::FileSystem::set_os_pmc($old_os);
        });
        &test();
        $c.verify();
    }

    method test_BUILD() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "t/harness");
        $!assert.not_null($file);
    }

    method exists() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "t/harness");
        my $e := $file.exists();
        $!assert.is_true($e);
    }

    method delete() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_mock_os($!status, -> $c {
            $c.expect_method("exists").once.with_args("foo.txt").will_return(1);
            $c.expect_method("rm").once.with_args("foo.txt");
        }, {
            $file.delete();
        });
    }

    method get_string() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "t/harness");
        $!assert.equal(~$file, "t/harness");
    }

    method rename() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_mock_os($!status, -> $c {
            $c.expect_method("rename").once.with_args("foo.txt", "bar.txt");
        }, {
            $file.rename("bar.txt");
        });
    }

    method short_name() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "t/harness");
        $!assert.equal($file.short_name(), "harness");
    }

    method open_read() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "r");
        }, {
            $file.open_read();
        });
    }

    method open_write() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "w");
        }, {
            $file.open_write();
        });
    }

    method open_append() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "a");
        }, {
            $file.open_append();
        });
    }

    method read_all_text() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "r");
            $c.expect_method("readall").with_no_args().will_return("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;
        }, {
            my $txt := $file.read_all_text();
            $!assert.equal($txt, "foo\nbar\nbaz");
        });
    }

    method read_all_lines() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "r");
            $c.expect_method("readall").with_no_args.will_return("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;
        }, {
            my @txt := $file.read_all_lines();
            $!assert.equal(+@txt, 3);
            $!assert.equal(~@txt[0], "foo");
            $!assert.equal(~@txt[1], "bar");
            $!assert.equal(~@txt[2], "baz");
        });
    }

    method write_all_text() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "w");
            $c.expect_method("print").with_args("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;
        }, {
            $file.write_all_text("foo\nbar\nbaz");
        });
    }

    method write_all_lines() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "w");
            $c.expect_method("print").with_args("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;
        }, {
            $file.write_all_lines(<foo bar baz>);
        });
    }

    method append_text() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "a");
            $c.expect_method("print").with_args("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;
        }, {
            $file.append_text("foo\nbar\nbaz");
        });
    }

    method copy() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "foo.txt");
        test_with_filehandle_mock($!status, -> $c {
            $c.expect_method("open").with_args("foo.txt", "r");
            $c.expect_method("readall").with_no_args.will_return("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;

            $c.expect_method("open").with_args("bar.txt", "w");
            $c.expect_method("print").with_args("foo\nbar\nbaz");
            $c.expect_method("close").with_no_args;
        }, {
            $file.copy("bar.txt")
        });
    }
}

