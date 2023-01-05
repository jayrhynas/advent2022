typealias Move = (Direction, Int)

enum Direction: String, CaseIterable {
    case up    = "U"
    case down  = "D"
    case left  = "L"
    case right = "R"

    var movement: Coord {
        switch self {
        case .up:    return Coord(row: -1, col:  0)
        case .down:  return Coord(row:  1, col:  0)
        case .left:  return Coord(row:  0, col: -1)
        case .right: return Coord(row:  0, col:  1)
        }
    }
}
