enum Outcome {
    case win, lose, tie

    init?<S: StringProtocol>(_ letter: S) {
        switch letter {
        case "X": self = .lose
        case "Y": self = .tie
        case "Z": self = .win
        default: return nil
        }
    }
}