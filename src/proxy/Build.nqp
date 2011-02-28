class Rosella::Proxy::Build {
    has $!target_class;

    method BUILD($target_class) {
        $!target_class := $target_class;
    }

    # Set up the proxy class with any necessary characteristics
    method setup_proxy_class($proxy_class) {
    }

    # Set up the proxy instance
    method setup_proxy_object($proxy, $controller) {
    }
}
