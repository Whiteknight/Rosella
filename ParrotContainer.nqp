class ParrotContainer {
    # Helper method to call a Parrot method on an object with the given
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
    # constructor for types which need that
    our sub build($proto, *@pos, *%named) {
        my $obj;
        if pir::isa($proto, "P6protoobject") {
            $obj := $proto.new;
        } else {
            $obj := pir::new__PP($proto);
        }
        my $method := pir::find_method__PPS($obj, "BUILD");
        if $method {
            $obj.BUILD(|@pos, |%named);
        }
        return $obj;
    }
}

