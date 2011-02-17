class Rosella::Harness::TestFile {
    has $!filename;
    has $!result;
    has $!errdetails;
    has $!status;
    has @!failures;
    has @!lines;
    has $!num_tests;
    has $!failed_tests;
    has $!passed_tests;

    method setup() {
        $!failed_tests := 0;
        $!passed_tests := 0;
        @!failures := [];
    }

    method total_tests() {
        return $!num_tests;
    }

    method failed_tests() {
        return $!failed_tests;
    }

    method passed_tests() {
        return $!passed_tests;
    }

    method list_of_failures() {
        return @!failures;
    }

    method filename($filename?) {
        if pir::defined($filename) {
            $!filename := $filename;
        }
        $!filename;
    }

    method print_result() {
        if $!result {
            pir::say("not ok ($!result)");
        } else {
            pir::say("ok");
        }
        if $!errdetails {
            # TODO: Break this out into a separate reporting class
            pir::say("# " ~ $!errdetails);
        }
    }

    method status() {
        return $!status;
    }

    # TODO: Break this out into a separate reporting class
    method print_filename($max_length?) {
        my $length := pir::length__IS($!filename);
        if ! pir::defined($max_length) || $max_length < $length {
            $max_length := $length;
        }
        my $diff := ($max_length - $length) + 3;
        my $elipses := pir::repeat__SSI('.', $diff);
        pir::print($!filename);
        pir::print(" $elipses ");
    }

    # TODO: Move into a utils class
    sub swap_handles(*%handles) {
        my %save_handles;
        my $interp := pir::getinterp();

        if pir::defined( %handles<stderr> ) {
            %save_handles<stderr> := $interp.stderr_handle();
            $interp.stderr_handle(%handles<stderr>);
        }

        if pir::defined( %handles<stdin> ) {
            %save_handles<stdin> := $interp.stdin_handle();
            $interp.stdin_handle(%handles<stdin>);
        }

        if pir::defined( %handles<stdout> ) {
            %save_handles<stdout> := $interp.stdout_handle();
            $interp.stdout_handle(%handles<stdout>);
        }

        %save_handles;
    }

    method compile_and_execute() {
        my $sub := self.compile_test();
        my $stdout := pir::new__PS("StringHandle");
        $stdout.open("blah", "rw");
        my %save_handles := swap_handles(:stdout($stdout), :stderr($stdout));
        try {
            $sub();
            CATCH {
                self.mark_test_abort($!);
            }
        }
        my $output := $stdout.readall();
        swap_handles(|%save_handles);
        @!lines := pir::split__PSS("\n", $output);
    }

    method compile_test() {
        pir::die("Must use a subclass");
    }

    method mark_test_abort($err) {
        $!result := "aborted prematurely";
        $!errdetails := $err;
        $!status := "ABORTED";
    }

    method mark_test_empty() {
        $!result := "no TAP output";
        $!status := "EMPTY";
    }

    method spawn_and_execute() {
        my $pipe := pir::new__PS("FileHandle");
        $pipe.encoding('utf8');
        my $cmd := self.get_spawn_command();
        $pipe.open($cmd, "rp");
        my $output := $pipe.readall();
        $pipe.close();
        my $exit_status := $pipe.exit_status();
        if $exit_status != 0 {
            self.mark_test_abort("Test aborted with exit code $exit_status");
        }
        @!lines := pir::split__PSS("\n", $output);
    }

    method get_spawn_command() {
        pir::die("Must use a subclass");
    }

    method run($run_inline = 0) {
        if $run_inline {
            self.compile_and_execute();
        } else {
            self.spawn_and_execute();
        }
        if $!status eq "ABORTED" {
            return;
        }
        if self.has_tap_output() {
            self.get_plan();
            self.parse();
        }
        else {
            self.mark_test_empty();
        }
    }

    # TODO: A more robust check
    method has_tap_output() {
        if +@!lines < 2 {
            return 0;
        }
        return 1;
    }

    method get_plan() {
        # TODO: Detect bad plan
        my $plan        := @!lines[0];
        my @plan_parts  := pir::split("..", $plan);
        my $!num_tests  := @plan_parts[1];
        @!lines.shift;
    }

    # TODO: refactor this out into a TAP parser class
    method parse() {
        for @!lines {
            my $line := $_;
            if $line {
                my $lineobj := Rosella::Harness::Line.new();
                $lineobj.set_line($line);
                if $lineobj.ignore() {
                    continue;
                }
                elsif $lineobj.success() {
                    $!passed_tests := $!passed_tests + 1;
                }
                else {
                    $!failed_tests := $!failed_tests + 1;
                    my $msg := "test " ~ $lineobj.number();
                    my $name := $lineobj.name();
                    if $name {
                        $msg := $msg ~ " : $name";
                    }
                    @!failures.push($msg);
                }
            }
        }
        if $!failed_tests {
            $!result := "Failed $!failed_tests / $!num_tests";
            $!status := "FAILED";
        }
        else {
            $!status := "PASSED";
        }
    }
}

class Rosella::Harness::TestFile::NQP is Rosella::Harness::TestFile {
    method compile_test() {
        my $compiler := pir::compreg__PS('NQP-rx');
        my $handle := pir::new__PS("FileHandle");
        $handle.open($!filename, 'r');

        my $code := $handle.readall();
        $handle.close();

        $code := $compiler.compile: $code;
        return $code[0];
    }

    method get_spawn_command() {
        # TODO: be more generic
        return "parrot-nqp $!filename";
    }
}

class Rosella::Harness::TestFile::PIR is Rosella::Harness::TestFile {
    method compile_test() {
        my $sub;
        my $filename := $!filename;
         Q:PIR {
            $P1 = find_lex "$filename"
            $P0 = new ['FileHandle']
            $P0.'open'($P1)
            $P2 = $P0.'readall'()
            $P0.'close'()
            $P3 = compreg 'PIR'
            $P4 = $P3($P2)
            $P4 = $P4[0]
            store_lex '$sub', $P4
        };
        return $sub;
    }

    method get_spawn_command() {
        # TODO: be more generic
        return "parrot $!filename";
    }
}
