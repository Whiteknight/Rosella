class ParrotTest::Harness::Loader {
    has $!os;

    my $!max_filename_length;

    method max_filename_length() {
        $!max_filename_length;
    }

    method get_dir_contents($path) {
        if ! pir::defined($!os) {
            $!os := pir::new__PS('OS');
        }

        my $contents;

        # TODO: Filter out files from directories
        # TODO: Have a flag to optionally recurse directories
        # TODO: Maybe read the shebang preamble to make sure we have the
        #       correct type of file.

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

    method get_tests_from_dirs(*@dirs) {
        $!max_filename_length := 0;
        my @tests := < >;
        for @dirs {
            my $dir := $_;
            my @rawfiles := self.get_dir_contents($dir);
            for @rawfiles {
                my $filename := $_;
                # TODO: Break these out into a list of include and exclude
                #       patterns
                next if pir::index__ISS($filename, ".t") == -1;
                next if pir::index__ISS($filename, ".OLD") != -1;

                $filename := "$dir/$filename";
                my $testobj := self.make_test_obj();
                $testobj.set_filename($filename);
                @tests.push($testobj);
                self.update_max_filename_length($filename);
            }
        }
        return @tests;
    }

    method get_test_from_files(*@filenames) {
        my @tests := < >;
        for @filenames {
            my $filename := $_;
            my $testobj := self.make_test_obj();
            $testobj.set_filename($filename);
            @tests.push($testobj);
            self.update_max_filename_length($filename);
        }
        return @tests;
    }

    method update_max_filename_length($filename) {
        my $length := pir::length__IS($filename);
        if $length > $!max_filename_length {
            $!max_filename_length := $length;
        }
        $!max_filename_length;
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

