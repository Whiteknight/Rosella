INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

Rosella::Test::test(ProxyTest);

class ProxyTest {
    method test_add_attribute() {
        my $class_obj := pir::new__PS('Class');
        Rosella::Proxy::add_proxy_class_private_attr($class_obj, "foo");
    }

    method test_set_attribute() {
        my $class_obj := pir::new__PS('Class');
        Rosella::Proxy::add_proxy_class_private_attr($class_obj, "foo");
        my $foo := pir::new__PP($class_obj);
        Rosella::Proxy::set_proxy_private_attr($foo, "foo", "hello");
    }

    method test_get_attribute() {
        my $class_obj := pir::new__PS('Class');
        Rosella::Proxy::add_proxy_class_private_attr($class_obj, "foo");
        my $foo := pir::new__PP($class_obj);
        Rosella::Proxy::set_proxy_private_attr($foo, "foo", "hello");
        my $value := Rosella::Proxy::get_proxy_private_attr($foo, "foo");
        Assert::equal($value, "hello");
    }
}
