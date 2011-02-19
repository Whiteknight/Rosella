class Rosella::Harness::Loader {
    has $!os;
    has @!files;
    has $!test_proto;

    method BUILD($proto) {
        $!test_proto := $proto;
        @!files := [];
        pir::loadlib("os");
        $!os := pir::new__PS('OS');
    }

    method max_filename_length() {
        my $max := 0;
        for @!files {
            my $file := $_;
            my $length := pir::length__iS($file);
            if $length > $max {
                $max := $length;
            }
        }
        return $max;
    }

    method prepare_new_run() {
        @!files := [];
    }

    method get_dir_contents($path, $recurse, @contents) {
        my $STAT_ISREG := 0x8000;
        my $STAT_ISDIR := 0x4000;
        my @contents_raw := $!os.readdir: ~$path;

        for @contents_raw {
            my $entry := "$path/$_";
            my @stat := $!os.stat($entry);
            my $isdir := pir::band__III(@stat[2], $STAT_ISDIR);
            my $isfile := pir::band__III(@stat[2], $STAT_ISREG);
            next if $_[0] eq ".";
            if $isfile == $STAT_ISREG && self.is_test($entry) {
                @contents.push($entry);
            }

            if $recurse && $isdir == $STAT_ISDIR {
                self.get_dir_contents($entry, $recurse, @contents);
            }
        }

        # TODO: Maybe read the shebang preamble to make sure we have the
        #       correct type of file.

    }

    # Determine if the file is a valid test. Probably best to override this in
    # a subclass if you need different behaviors.
    method is_test($filename) {
        if (pir::index__ISS($filename, ".t") == -1) { return 0; }
        if (pir::index__ISS($filename, ".OLD") != -1) { return 0; }
        return 1;
    }

    method get_tests_from_dirs(@dirs, $recurse) {
        my @tests := < >;
        for @dirs {
            my $dir := $_;
            my @rawfiles := [];
            self.get_dir_contents($dir, $recurse, @rawfiles);
            for @rawfiles {
                my $filename := $_;
                my $testobj := self.make_test_obj($filename);
                @tests.push($testobj);
                @!files.push($filename);
            }
        }
        return @tests;
    }

    method get_tests_from_files(@filenames) {
        my @tests := [];
        for @filenames {
            my $filename := $_;
            my $testobj := self.make_test_obj($filename);
            @tests.push($testobj);
            @!files.push($filename);
        }
        return @tests;
    }


    method make_test_obj($filename) {
        Rosella::build($!test_proto, $filename);
    }
}


