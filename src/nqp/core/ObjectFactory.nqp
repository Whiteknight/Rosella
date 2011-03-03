class Rosella::ObjectFactory {
    method create($type, *@pos, *%named) {
        return Rosella::build($type, |@pos, |%named);
    }
}


