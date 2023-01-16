import struct Util.Coord

extension Coord {
    func manhattanDistance(to other: Coord) -> Int {
        abs(x - other.x) + abs(y - other.y)
    }
}