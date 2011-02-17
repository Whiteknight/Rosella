class Rosella::ItemCreator {
    method create($type, *@pos, *%named) {
        Rosella::Error::must_subclass(Rosella::ItemCreator, "create");
    }
}

class Rosella::ItemCreator::Default {
    method create($type, *@pos, *%named) {
        return Rosella::build($type, |@pos, |%named);
    }
}

