# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Rosella::Loader {
    has $!class;
    has %!seen_methods;
    has $!test_prefix;

    sub compare_methods($a, $b) {
        pir::cmp__ISS(~$a, ~$b);
    }

    our method configure_suite(@tests, :$suite = self.default_suite, *%named) {
        my $metaclass := pir::getprop__psp('metaclass', $!class);
        my $protoobject := pir::getattribute__pps($metaclass, 'protoobject');

        for @tests -> $test {
            my $test_obj := $protoobject.new();
            $test_obj.name($test);
            $suite.add_test: $test_obj
        }

        $suite;
    }

    our method default_suite() {
        my $suite := Rosella::Suite.new();
        $suite.BUILD();
        return $suite;
    }

    sub hash_contains(%hash, $key) {
        return Q:PIR {
            $P0 = find_lex '%hash'
            $P1 = find_lex '$key'
            $I0 = exists $P0[$P1]
            %r = box $I0
        };
    }

    sub array_unsort(@array) {
        my $bound := pir::elements(@array) - 1;
        my $swap;
        my $temp;
        return @array;

        #while $bound > 0 {
        #    $swap := pir::rand__iiii(0, $bound);
        #    $swap-- if $swap > $bound;      # Rare but possible
        #    $temp := @array[$bound];
        #    @array[$bound] := @array[$swap];
        #    @array[$swap] := $temp;
        #    $bound--;
        #}

        #@array;
    }

    our method get_test_methods() {
        my @mro := $!class.inspect('all_parents');
        my @test_methods := [ ];

        for @mro {
            my %methods := $_.inspect('methods');

            for %methods {
                my $name := ~ $_;

                if self.is_test_method($name) && !hash_contains(%!seen_methods, $name) {
                    %!seen_methods{$name} := 1;
                    @test_methods.push($name);
                }
            }
        }

        self.order_tests(@test_methods);
    }

    our method _init_obj(*@pos, *%named) {
        $!test_prefix := 'test';

        self._init_args(|@pos, |%named);
    }

    # Returns true for "test_foo" and "testFoo" names
    our method is_test_method($name) {
        my $result := 0;

        if pir::length($name) > 4 && pir::substr($name, 0, 4) eq 'test' {

            my $ch4 := $name[4];

            # TODO: Translate this out. I don't think is_cclass is a method
            #       on String
            if $ch4 eq '_'
                || $ch4.is_cclass(String::CharacterClass::UPPERCASE)
                || $ch4.is_cclass(String::CharacterClass::NUMERIC) {
                $result := 1;
            }
        }

        $result;
    }

    our method load_tests_from_testcase($class, *%named) {
        $!class := P6metaclass.get_parrotclass($class);
        my @tests := self.get_test_methods;

        self.configure_suite(@tests, |%named);
    }

    our method order_tests(@tests) {
        array_unsort(@tests);
    }

    our method test_prefix($value?) {
        $value ?? ($!test_prefix := $value) !! $!test_prefix;
    }
}
