enum Command {
    enum Target {
        case root, up, down(String)
    }

    case cd(Target)

    enum Listing {
        case dir(String)
        case file(Int, String)
    }

    case ls([Listing])
}