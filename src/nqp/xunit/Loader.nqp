class Rosella::Loader {
    has $!class;
    has %!seen_methods;
    has $!test_prefix;

    method BUILD(:$prefix?) {
        if pir::defined($prefix) {
            $!test_prefix := $prefix;
        } else {
            $!test_prefix := "test_";
        }
    }

    sub compare_methods($a, $b) {
        pir::cmp__ISS(~$a, ~$b);
    }

    our method configure_suite(@tests, :$suite = self.default_suite, *%named) {
        my $metaclass := pir::getprop__psp('metaclass', $!class);
        my $protoobject := pir::getattribute__pps($metaclass, 'protoobject');

        for @tests -> $test {
            my $test_obj := Rosella::build($protoobject, $test);
            $suite.add_test: $test_obj
        }

        $suite;
    }

    our method default_suite() {
        my $suite := Rosella::build(Rosella::Suite);
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

        # TODO: Reimplement this.
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

    # Returns true for "test_foo" and "testFoo" names
    our method is_test_method($name) {
        my $result := 0;
        my $prefixlength := pir::length($!test_prefix);

        if pir::length($name) > $prefixlength &&
            pir::substr($name, 0, $prefixlength) eq $!test_prefix {
            $result := 1;
        }

        $result;
    }

    our method load_tests_from_testcase($type, *%named) {
        $!class := Rosella::get_type_class($type);
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
