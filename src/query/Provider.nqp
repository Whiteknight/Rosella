class Rosella::Query::Provider {
    # For every item in the aggregate, return a new item instead
    method map($data, &func) {
        Rosella::Error::must_subclass(Rosella::Query::Provider);
    }

    # Return an aggregate of only the elements which match the filter
    method filter($data, &func) {
        Rosella::Error::must_subclass(Rosella::Query::Provider);
    }

    # Return a single value from the aggregate
    method fold($seed, $data, &func) {
        Rosella::Error::must_subclass(Rosella::Query::Provider);
    }

    # Return the items in the aggregate. If a filter is provided, return
    # The number of items which satisfy the filter
    method count($data, &func?) {
        if pir::defined(&func) {
            my $new_data := self.filter($data, &func);
            return pir::elements($new_data);
        }
        return pir::elements($data);
    }

    # Return a list of only the first N items which match a filter
    method take($data, $count, &func?) {
        Rosella::Error::must_subclass(Rosella::Query::Provider);
    }

    # Return a list of all the items EXCEPT the first N items which match
    # a filter
    method skip($data, $count, &func?) {
        Rosella::Error::must_subclass(Rosella::Query::Provider);
    }

    # combine two aggregates together. Takes two optional routines:
    # &filter is a routine to filter down the two data sets.
    # &key_func generates a unique key for each element. If provided,
    # we avoid duplicate keys. If not used, each individual provider may
    # have a default method of determining keys (if applicable).
    # &dispute resolves a dispute where two items have the same key
    # Notice that this method does not guarantee to maintain any ordering
    # of the indivual aggregates.
    method join($a, $b, :&filter?, :&key_func?, :&dispute?) {
    }
}
