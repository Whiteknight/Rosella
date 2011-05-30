INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::File);

class Test::FileSystem::File {
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
    }

    method get_string() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "t/harness");
        $!assert.equal(~$file, "t/harness");
    }

    method rename() {
    }

    method short_name() {
        my $file := Rosella::construct(Rosella::FileSystem::File, "t/harness");
        $!assert.equal($file.short_name(), "harness");
    }

    method open_read() {
    }

    method open_write() {
    }

    method open_append() {
    }

    method read_all_text() {
    }

    method read_all_lines() {
    }

    method write_all_text() {
    }

    method write_all_lines() {
    }

    method append_text() {
    }

    method copy() {
    }
}
