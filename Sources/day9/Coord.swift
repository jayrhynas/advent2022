struct Coord: Hashable {
    var row: Int
    var col: Int

    static let zero = Coord(row: 0, col: 0)
}

func +(lhs: Coord, rhs: Coord) -> Coord {
    Coord(row: lhs.row + rhs.row,
          col: lhs.col + rhs.col)
}

func +=(lhs: inout Coord, rhs: Coord) {
    lhs = lhs + rhs
}

func -(lhs: Coord, rhs: Coord) -> Coord {
    Coord(row: lhs.row - rhs.row,
          col: lhs.col - rhs.col)
}
