class Rosella::ObjectFactory {
    method create($type, *@pos, *%named) {
        Rosella::Error::must_subclass(Rosella::ItemCreator, "create");
    }
}

class Rosella::ObjectFactory::Default {
    method create($type, *@pos, *%named) {
        return Rosella::build($type, |@pos, |%named);
    }
}

