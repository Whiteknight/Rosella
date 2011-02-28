class Rosella::Proxy::MethodProxy {
    has $!target;
    has $!controller;

    method BUILD($target, $controller?) {
        $!target := $target;
        $!controller := $controller;
    }

}
