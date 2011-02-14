class ParrotTest::Harness::Loader {
    has $!os;
    has @!files;

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
        if ! pir::defined($!os) {
            pir::loadlib("os");
            $!os := pir::new__PS('OS');
        }

        my $STAT_ISREG := 0x8000;
        my $STAT_ISDIR := 0x4000;
        my @contents_raw := $!os.readdir: ~$path;

        for @contents_raw {
            my $entry := "$path/$_";
            my @stat := $!os.stat($entry);
            my $isdir := pir::band__III(@stat[2], $STAT_ISDIR);
            my $isfile := pir::band__III(@stat[2], $STAT_ISREG);
            next if $_[0] eq ".";
            if $isfile == $STAT_ISREG {
                @contents.push($entry);
            }

            if $recurse && $isdir == $STAT_ISDIR {
                self.get_dir_contents($entry, $recurse, @contents);
            }
        }

        # TODO: Maybe read the shebang preamble to make sure we have the
        #       correct type of file.

    }

    method get_tests_from_dirs(@dirs, $recurse) {
        my @tests := < >;
        for @dirs {
            my $dir := $_;
            my @rawfiles := [];
            self.get_dir_contents($dir, $recurse, @rawfiles);
            for @rawfiles {
                my $filename := $_;
                # TODO: Break these out into a list of include and exclude
                #       patterns
                next if pir::index__ISS($filename, ".t") == -1;
                next if pir::index__ISS($filename, ".OLD") != -1;

                my $testobj := self.make_test_obj();
                $testobj.filename: $filename;
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
            my $testobj := self.make_test_obj();
            $testobj.filename($filename);
            @tests.push($testobj);
            @!files.push($filename);
        }
        return @tests;
    }


    method make_test_obj() {
        pir::die("Must use a subclass");
    }
}

class ParrotTest::Harness::Loader::NQP is ParrotTest::Harness::Loader {
    method make_test_obj() {
        ParrotTest::Harness::TestFile::NQP.new();
    }
}

class ParrotTest::Harness::Loader::PIR is ParrotTest::Harness::Loader {
    method make_test_obj() {
        ParrotTest::Harness::TestFile::PIR.new();
    }
}

