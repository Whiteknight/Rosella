module Error {
    our sub must_subclass($name) {
        pir::die("Rosella ($name) : You must use a subclass instead");
    }

    our sub invalid($name, $err) {
        pir::die("Rosella ($name) : $err");
    }

    our sub not_implemented($class, $func) {
        pir::die("Rosella ($class . $func) : Not implemented");
    }
}
