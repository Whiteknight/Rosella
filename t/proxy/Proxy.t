INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "proxy");
}

Rosella::Test::test(ProxyTest);

class MyClass { }

class ProxyTest {
    method test_add_attribute() {
        my $class_obj := pir::new__PS('Class');
        Rosella::Proxy::add_proxy_class_private_attr($class_obj, "foo");
    }

    method test_set_attribute() {
        my $class_obj := pir::new__PS('Class');
        pir::say($class_obj);
        Rosella::Proxy::add_proxy_class_private_attr($class_obj, "foo");
        my $foo := pir::new__PP($class_obj);
        Rosella::Proxy::set_proxy_private_attr($foo, "foo", "hello");
    }

    method test_get_attribute() {
        my $class_obj := pir::new__PS('Class');
        pir::say($class_obj);
        Rosella::Proxy::add_proxy_class_private_attr($class_obj, "foo");
        my $foo := pir::new__PP($class_obj);
        Rosella::Proxy::set_proxy_private_attr($foo, "foo", "hello");
        my $value := Rosella::Proxy::get_proxy_private_attr($foo, "foo");
        $!assert.equal($value, "hello");
    }

    method is_proxy() {
        $!assert.is_false(Rosella::Proxy::is_proxy(MyClass.new()));
        my $factory := Rosella::construct(Rosella::Proxy::Factory, MyClass, []);
        my $p := $factory.create(Rosella::construct(Rosella::Proxy::Controller));
        $!assert.is_true(Rosella::Proxy::is_proxy($p));
    }
}
