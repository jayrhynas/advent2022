struct Coord: Hashable {
    var row: Int
    var col: Int

    static let zero = Coord(r: 0, c: 0)

    init(r: Int, c: Int) {
        row = r
        col = c
    }

    func move(_ dir: Direction) -> Coord {
        switch dir {
        case .up:    return Coord(r: row - 1, c: col)
        case .down:  return Coord(r: row + 1, c: col)
        case .left:  return Coord(r: row, c: col - 1)
        case .right: return Coord(r: row, c: col + 1)
        }
    }
}
