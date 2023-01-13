import struct Util.Coord

typealias Move = (Direction, Int)

enum Direction: String, CaseIterable {
    case up    = "U"
    case down  = "D"
    case left  = "L"
    case right = "R"

    var movement: Coord {
        switch self {
        case .up:    return Coord(-1,  0)
        case .down:  return Coord( 1,  0)
        case .left:  return Coord( 0, -1)
        case .right: return Coord( 0,  1)
        }
    }
}
