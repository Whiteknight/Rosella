INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

Rosella::Test::test(Test::FileSystem::Directory);

class Test::FileSystem::Directory {
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

    method current_directory() {
        my $pwd := Rosella::FileSystem::Directory::current_directory();
        $!assert.not_null($pwd);
        $!assert.instance_of($pwd, Rosella::FileSystem::Directory);
    }

    method test_BUILD() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.not_null($dir);
        $!assert.instance_of($dir, Rosella::FileSystem::Directory);
    }

    method exists() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.is_true($dir.exists);
    }

    method exists_fail() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "WHARBLEGARBLE");
        $!assert.is_false($dir.exists);
    }

    method delete() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "WHARBLEGARBLE");
        test_with_mock_os($!status, -> $c {
            $c.expect_method("exists").once.with_any_args.will_return(1);
            $c.expect_method("rm").once.with_args("WHARBLEGARBLE/");
        }, {
            $dir.delete();
        });
    }

    method get_string() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.equal(~$dir, "t/");
    }

    method rename() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "WHARBLEGARBLE");
        test_with_mock_os($!status, -> $c {
            $c.expect_method("rename").once.with_args("WHARBLEGARBLE/", "FooBar");
        }, {
            $dir.rename("FooBar");
        });
    }

    method short_name() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.equal($dir.short_name, "t");
    }

    method delete_recursive() {
        $!status.unimplemented("Find a way to test Directory.delete_recursive");
    }

    method create() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "WHARBLEGARBLE");
        test_with_mock_os($!status, -> $c {
            $c.expect_method("exists").once.with_args("WHARBLEGARBLE/").will_return(0);
            $c.expect_method("mkdir").once.with_args("WHARBLEGARBLE/", 493);
        }, {
            $dir.create();
        });
    }

    method get_files() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t/filesystem");
        my @files := $dir.get_files;
        $!assert.is_true(+@files > 0);
        # TODO: Can we have a better, more specific test?
    }

    method get_subdirectories() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t/filesystem");
        my @subdirs := $dir.get_subdirectories;
        $!assert.equal(+@subdirs, 1);
        $!assert.equal(~@subdirs[0], "t/filesystem/visitor/");
    }

    method walk() {
        $!status.unimplemented("Need tests for Directory.walk");
    }

    method walk_func() {
        $!status.unimplemented("Need tests for Directory.walk_func");
    }

    method get_pmc_keyed() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t/filesystem");
        my $file := $dir{"FileSystem.t"};
        $!assert.not_null($file);
        $!assert.instance_of($file, Rosella::FileSystem::File);

        my $subdir := $dir{"visitor"};
        $!assert.not_null($subdir);
        $!assert.instance_of($subdir, Rosella::FileSystem::Directory);
    }

    method exists_keyed() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        my $file_exists := Q:PIR {
            $P0 = find_lex "$dir"
            $I0 = exists $P0["harness"]
            %r = box $I0
        };
        $!assert.is_true($file_exists);
    }

    method exists_keyed_fail() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        my $file_exists := Q:PIR {
            $P0 = find_lex "$dir"
            $I0 = exists $P0["WHARBLEGARBLE"]
            %r = box $I0
        };
        $!assert.is_false($file_exists);
    }

    method delete_keyed() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "WHARBLEGARBLE");
        test_with_mock_os($!status, -> $c {
            $c.expect_method("exists").once.with_args("WHARBLEGARBLE/foo.txt").will_return(1);
            $c.expect_method("rm").once.with_args("WHARBLEGARBLE/foo.txt");
        }, {
            Q:PIR {
                $P0 = find_lex '$dir'
                delete $P0["foo.txt"]
            }
        });
    }
}
