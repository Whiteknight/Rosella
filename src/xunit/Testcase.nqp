# Copyright (C) 2009-2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Rosella::Testcase {
    has $!todo;
    has $!verify;
    has $!name;

    method BUILD($name) {
        $!name := $name;
    }

    our sub test($testproto, :$loaderproto?, *%opts) {
        my $loader;
        if pir::defined($loaderproto) {
            $loader := Rosella::build($loaderproto);
        } else {
            $loader := Rosella::build(Rosella::Loader);
        }
        my $suite := $loader.load_tests_from_testcase($testproto);
        $suite.name: "Test suite for " ~ pir::typeof__SP($testproto.WHAT);
        $suite.run();
    }

    our method __name() { $!name; }

    our method __num_tests() { 1; }

    our method __set_up() { }

    our method __tear_down() { }

    # Provide an alternate text to display on output
    our method verify($verify?) { pir::defined__IP($verify) ?? ($!verify := $verify) !! $!verify; }

    our method todo($todo?) { pir::defined__IP($todo) ?? ($!todo := $todo) !! $!todo; }

    our method unimplemented($msg) {
        self.todo($msg);
        Assert::fail("Unimplemented: " ~ $!name);
    }
}
