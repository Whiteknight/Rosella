INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::Directory);

class Test::FileSystem::Directory {
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
        $!status.unimplemented("Find a way to test Directory.delete");
    }

    method get_string() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.equal(~$dir, "t/");
    }

    method rename() {
        $!status.unimplemented("Find a way to test Directory.rename");
    }

    method short_name() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.equal($dir.short_name, "t");
    }

    method delete_recursive() {
        $!status.unimplemented("Find a way to test Directory.delete_recursive");
    }

    method create() {
        $!status.unimplemented("Find a way to test Directory.create");
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
    }

    method walk_func() {
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
        $!status.unimplemented("Find a way to test Directory.delete");
    }
}
