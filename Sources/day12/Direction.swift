enum Direction: String, CaseIterable {
    case up    = "^"
    case down  = "v"
    case left  = "<"
    case right = ">"

    var opposite: Direction {
        switch self {
        case .up:    return .down
        case .down:  return .up
        case .left:  return .right
        case .right: return .left
        }
    }
}
