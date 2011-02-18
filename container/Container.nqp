class Rosella::Container {
    has %!library;
    has $!default_factory;
    our $default_container;

    sub new_hash(*%hash) { %hash; }

    method BUILD(:$factory?) {
        %!library := new_hash();
        if pir::defined($factory) {
            $!default_factory := $factory;
        } else {
            $!default_factory := Rosella::ObjectFactory::Default.new;
        }
    }

    # A readily-available global container instance. Creates a new container
    # if one has not already be set as the global default.
    our sub default_container($new_cont?) {
        our $default_container;
        if pir::defined($new_cont) {
            $default_container := $new_cont;
        }
        if pir::defined($default_container) {
            return $default_container;
        }
        $default_container := create(Rosella::Container);
        return $default_container;
    }

    # Registration Methods

    # $init_pmc is passed to the init_pmc/instantiate vtable
    # @meth_inits is a list of MethodInitializers, invoked in order
    method register_type($type, :$init_pmc?, :@meth_inits?) {
        my $name := Rosella::get_type_name($type);
        my $item := self.get_generator_item($type, $init_pmc, @meth_inits);
        %!library{$name} := $item;
    }

    method register_prototype($type, $proto, :@meth_inits?) {
        my $name := Rosella::get_type_name($type);
        my $item := self.get_prototype_item($proto, @meth_inits);
        %!library{$name} := $item;
    }

    method register_instance($instance, :@meth_inits?) {
        my $type := self.get_instance_type($instance);
        self.register_instance($type, $instance, :meth_inits(@meth_inits));
    }

    method register_instance($type, $instance, :@meth_inits?) {
        my $name := Rosella::get_type_name($type);
        my $item := self.get_instance_item($instance, @meth_inits);
        %!library{$name} := $item;
    }

    method register_factory_method($type, &factory, :@meth_inits?, :@arg_inits?) {
        my $name := Rosella::get_type_name($type);
        my $item := self.get_factory_method_item(&factory, @meth_inits, @arg_inits);
        %!library{$name} := $item;
    }

    # Resolve Methods

    # Full resolution. Look for a registered type to resolve. If not found,
    # attempt to create a fresh item of the given type.
    method resolve($type, *@overrides, *%named_opts) {
        my $name := Rosella::get_type_name($type);
        my $item := %!library{$name};
        if pir::defined($item) {
            return $item.resolve(@overrides);
        }
        return self.resolve_create($type, @overrides);
    }

    # Create a new object only. Do not attempt to resolve from the library
    # of registered types.
    method resolve_create($type, @actions?) {
        return $!default_factory.create($type, @actions);
    }

    # Resolve from the library only. Attempting to resolve a type that has
    # not previously been registered causes an error
    method resolve_nocreate($type, @overrides?, *%named_opts) {
        my $name := Rosella::get_type_name($type);
        my $item := %!library{$name};
        if pir::defined($item) {
            return $item.resolve(@overrides);
        }
        Rosella::Error::invalid(Rosella::Container, "Type $name not registered");
    }

    # Get Item Methods
    # Get a Rosella::Container::Item object for storing information
    # about a type

    # Get a Container::Item that returns an existing instance
    method get_instance_item($instance, @meth_inits) {
        my $item := create(Rosella::ItemBuilder::Instance,
                $instance, @meth_inits);
        return $item;
    }

    # Get a Container::Item that returns a clone of an existing prototype
    method get_prototype_item($proto, @meth_inits) {
        my $item := create(Rosella::ItemBuilder::Prototype,
                $proto, @meth_inits);
        return $item;
    }

    # Get a Container::Item that returns a factory-type resolver.
    # $type may any of the standard type identifier types.
    method get_generator_item($type, $init_pmc, @meth_inits) {
        my $item;
        # TODO: Arguments for BUILD?
        if pir::isa($type, "P6protoobject") {
            $item := create(Rosella::ItemBuilder::P6protoobject,
                    $type, @meth_inits);
        } elsif pir::isa($type, "Class") {
            $item := create(Rosella::ItemBuilder::ParrotClass,
                    $type, $init_pmc, @meth_inits);
        } else {
            my $class := Rosella::get_type_class($type);
            $item := create(Rosella::ItemBuilder::ParrotClass,
                    $class, $init_pmc, @meth_inits);
        }
        return $item;
    }

    # Get a Container::Item that uses a factory method to create a new object
    # instance.
    method get_factory_method_item(&sub, @meth_inits, @arg_inits) {
        my $item := create(Rosella::ItemBuilder::FactoryMethod,
                &sub, @meth_inits, @arg_inits);
        return $item;
    }

    # Helper Methods

    # Give this routine a shorter name, since it's so common and important
    sub create($proto, *@pos, *%named) {
        return Rosella::build($proto, |@pos, |%named);
    }
}


