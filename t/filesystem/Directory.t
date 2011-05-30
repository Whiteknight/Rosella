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
        $!assert.not_null($pwd);
        $!assert.instance_of($pwd, Rosella::FileSystem::Directory);
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

    }

    method get_string() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.equal(~$dir, "t");
    }

    method rename() {
    }

    method short_name() {
        my $dir := Rosella::construct(Rosella::FileSystem::Directory, "t");
        $!assert.equal($dir.short_name, "t");
    }

    method delete_recursive() {
    }

    method create() {
    }

    method get_files() {
    }

    method get_subdirectories() {
    }

    method walk() {
    }

    method walk_func() {
    }
}
