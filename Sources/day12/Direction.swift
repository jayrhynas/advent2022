import struct Util.Coord

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

    var movement: Coord {
        switch self {
        case .up:    return Coord(-1, 0)
        case .down:  return Coord( 1, 0)
        case .left:  return Coord( 0, -1)
        case .right: return Coord( 0,  1)
        }
    }
}
