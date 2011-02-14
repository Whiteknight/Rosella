class ParrotTest::Harness::Loader {
    my @!tests;

    method setup(@*dirs) {
        @!tests := get_all_tests(@dirs);
    }

    method tests() {
        @!tests;
    }

    method get_dir_contents($path) {
        my $contents;

        #if self.is_file: $path {
        #    %named<mode> := 'r';
        #    my $fh := self.open($path, |%named);
        #    $contents := $fh.readall;
        #    $fh.close;
        #}
        #elsif self.is_directory: $path {
            $contents := $!os.readdir: ~$path;
        #}
        #else {
            # What to do?
            #pir::die("Don't know how to get contents of non-file, non-directory: $path");
        #}

        $contents;
    }

    method get_all_tests(@dirs) {
        my $max_length := 0;
        for @dirs {
            my $dir := $_;
            my @rawfiles := self.get_dir_contents($dir);
            for @rawfiles {
                my $filename := $_;
                if pir::index__ISS($filename, ".t") == -1 {
                    next;
                }
                if pir::index__ISS($filename, ".OLD") != -1 {
                    next;
                }

                $filename := "$dir/$filename";
                my $testobj := self.make_test_obj();
                $testobj.set_filename($filename);
                @!files.push($testobj);
                my $length := pir::length__IS($filename);
                if $length > $!max_length {
                    $!max_length := $length;
                }
            }
        }
    }

    method make_test_obj() {
        pir::die("Must use a subclass");
    }
}

class ParrotTest::Harness::Loader::NQP {
    method make_test_obj() {
        ParrotTest::Harness::Test::NQP.new();
    }
}

class ParrotTest::Harness::Loader::PIR {
    method make_test_obj() {
        ParrotTest::Harness::Test::PIR.new();
    }
}



}
