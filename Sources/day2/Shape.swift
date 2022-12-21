enum Shape {
    case rock, paper, scissors

    init?<S: StringProtocol>(_ letter: S) {
        switch letter {
        case "A", "X": self = .rock
        case "B", "Y": self = .paper
        case "C", "Z": self = .scissors
        default: return nil
        }
    }
}