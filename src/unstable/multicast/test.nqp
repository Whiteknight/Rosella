class ExecutionChain {
    has @!funcs;

    method add_func($func)
        pir::shift(@!funcs, $func);
    }

    # execute all, returning an array of return values
    method execute_all(*@args) {
        my $i := 0;
        my @results;

        while $i < +@!funcs {
            @results[$i] := @!funcs[$i](|@args);
        }
        return @results;
    }

    # execute all, passing the results of each into the args of the next one.
    # Return the final result
    method execute_chain(*@args) {
        my $i := 1;
        my @results = @!funcs[0](|@args);
        while $i < +@!funcs {
            @results = @!funcs[$i](|@results);
        }
        return @results;
    }

    # execute all, using an aggregator routine to combine results into a
    # single return value;
    method execute_aggregate($aggregate, $init, *@args) {
        my $i := 0;
        my $result := pir::clone($init);

        while $i < +@!funcs {
            my $value := @!funcs[$i](|@args);
            $result := $aggregate($result, $value);
        }
        return $result;
    }


}
