class Rosella::Prototype::Item {
    has $!prototype;
    has &!constructor;

    method BUILD($proto, &sub?) {
        $!prototype := $proto;
        if pir::defined(&sub) {
            &!constructor := &sub;
        }
    }

    method create() {
        my $item := pir::clone($!prototype);
        return $item;
    }

    method construct($item, @pos?, %named?) {
        if pir::defined(&!constructor) {
            Rosella::call_parrot_method($item, &!constructor, @pos, %named);
        }
    }

    method prototype($proto?) {
        if pir::defined($proto) {
            $!prototype := $proto;
        }
        $!prototype;
    }

    method constructor(&sub?) {
        if pir::defined(&sub) {
            &!constructor := &sub;
        }
        return &!constructor;
    }
}
