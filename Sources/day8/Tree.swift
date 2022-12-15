struct Tree: CustomStringConvertible {
    let height: Int
    var visible: [Dir: Bool] = [:]

    var isVisible: Bool {
        !self.visible.values.allSatisfy { $0 == false }
    }

    var description: String {
        "Tree(\(height), " + Dir.allCases.map {
            switch visible[$0] {
            case .some(true): return $0.rawValue
            case .some(false): return " "
            case .none: return "?"
            }
        }.joined() + ")"
    }
}