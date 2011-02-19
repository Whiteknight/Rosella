class Rosella::Listener::TAP is Rosella::Listener {
    has $!test_builder;

    method BUILD() {
        $!test_builder := Rosella::build(Rosella::Test::Builder);
    }

    our method add_error($failure) {
        self.add_failure($failure);    # Same for our purposes
    }

    our method add_failure($failure) {
        my $test := $failure.test_case;
        my $label := self.get_test_label($test);

        if $test.todo {
            self.test_builder.todo(0, $label, $test.todo);
        }
        else {
            self.test_builder.ok(0, self.get_test_label($failure.test_case));
        }

        my $ex := $failure.fault;
        my $msg := Q:PIR {
            $P0 = find_lex "$ex"
            %r = $P0["message"]
        };
        self.test_builder.diag($msg);
        self;
    }

    our method end_test($test) {
        my $label := self.get_test_label($test);

        if $test.todo {
            self.test_builder.todo(1, $label, $test.todo);
        }
        else {
            self.test_builder.ok(1, self.get_test_label($test));
        }

        self;
    }

    our method get_test_label($test) {
        $test.verify || $test.__name || '';
    }

    our method plan_tests($num_tests) {
        self.test_builder.plan($num_tests);
    }

    our method test_builder() { $!test_builder; }
}

