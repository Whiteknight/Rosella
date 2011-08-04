INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "filesystem");
}

Rosella::Test::test(Test::FileSystem);

class Test::FileSystem {
    method get_os_pmc() {
        my $os := Rosella::FileSystem::get_os_pmc();
        $!assert.not_null($os);
        $!assert.instance_of($os, "OS");
    }

    method set_os_pmc() {
        my $os := "whatever";
        Rosella::FileSystem::set_os_pmc($os);
        my $new_os := Rosella::FileSystem::get_os_pmc();
        $!assert.not_null($os);
        $!assert.equal($new_os, "whatever");
        $os := pir::new__PS("OS");
        Rosella::FileSystem::set_os_pmc($os);
    }

    method is_file() {
        pir::say(Rosella::FileSystem::Directory::current_directory());
        $!assert.is_true(Rosella::FileSystem::is_file("t/harness"));
        $!assert.is_false(Rosella::FileSystem::is_file("t/WHARBLEGARBLE"));
    }

    method is_directory() {
        $!assert.is_true(Rosella::FileSystem::is_directory("t/"));
        $!assert.is_false(Rosella::FileSystem::is_file("WHARBLEGARBLE"));
    }

    method path_separator() {
        $!status.unimplemented("find a way to test path_separator in a platform-independent way");
    }
}
