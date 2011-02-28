class Rosella {
    # Helper routine to call a Parrot method on an object with the given
    # arguments
    our sub call_parrot_method($object, $method, @pos, %named) {
        my $n := %named;
        Q:PIR {
            .local pmc obj, meth, pos, named
            obj = find_lex "$object"
            meth = find_lex "$method"
            pos = find_lex "@pos"
            $P0 = find_lex "$n"

            $I0 = isa meth, "String"
            if $I0 goto is_string
            .tailcall obj.meth(pos :flat)

          is_string:
            $S0 = meth
            .tailcall obj.$S0(pos :flat)
        }
    }

    # Instantiate a Class or P6protoobject, and call the .BUILD method on it,
    # if one exists in the class. This acts like an implementation of a
    # constructor for types which need that.
    our sub build($proto, *@pos, *%named) {
        my $obj;
        if pir::isa($proto, "P6protoobject") {
            $obj := $proto.new;
        } else {
            my $class := get_type_class($proto);
            $obj := pir::new__PP($class);
        }
        my $method;
        try {
            $method := pir::find_method__PPS($obj, "BUILD");
            CATCH {
                $method := pir::new__PS("Undef");
            }
        }
        if pir::defined($method) {
            #call_parrot_method($obj, $method, @pos, %named);
            $obj.BUILD(|@pos, |%named);
        }
        return $obj;
    }

    # Return a stringified type name for the object. $type could be a
    # NameSpace, a Class, a P6metaclass, a P6protoobject, a Key, a
    # *StringArray or a String.
    our sub get_type_name($type) {
        if pir::isa($type, "String") {
            return $type;
        }

        # If we have these objects, try to get the Parrot NameSpace for
        # easy stringification
        if pir::isa($type, "P6protoobject") {
            $type := $type.HOW().get_parrotclass().get_namespace();
        } elsif pir::isa($type, "P6metaclass") {
            $type := $type.get_parrotclass().get_namespace();
        } elsif pir::isa($type, "Class") {
            $type := $type.get_namespace();
        } elsif pir::isa($type, "Key") {
            $type := pir::get_namespace__PP($type);
        }

        if pir::isa($type, "NameSpace") {
            return pir::join("::", $type.get_name());
        }
        if pir::does($type, "Array") {
            return pir::join("::", $type);
        }
        return ~$type;
    }

    # Look up a Parrot Class PMC for the given type. $type can be any of
    # the PMC types used in get_type_name above
    our sub get_type_class($type) {
        if pir::isa($type, "P6metaclass") {
            return $type.get_parrotclass();
        }
        if pir::isa($type, "P6protoobject") {
            return P6metaclass.get_parrotclass($type);
        }
        if pir::isa($type, "Class") {
            return $type;
        }
        if pir::isa($type, "String") {
            $type := pir::split__PSS("::", $type);
        }
        return pir::get_class__PP($type);
    }

    sub verify_constructor_arg($val, $class, $name, :$isa?, :$does?, :$can?) {
        if ! pir::defined($val) {
            Rosella::Error::variable($class, $name, "failed defined");
        }
        if pir::defined($isa) && !pir::isa($val, $isa) {
            Rosella::Error::variable($class, $name, "failed isa $isa");
        }
        if pir::defined($does) && !pir::does($val, $does) {
            Rosella::Error::variable($class, $name, "failed does $does");
        }
        if pir::defined($can) && !pir::can($val, $can) {
            Rosella::Error::variable($class, $name, "failed can $can");
        }
    }
}

