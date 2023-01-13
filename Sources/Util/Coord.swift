public struct Coord: Hashable {
    public var row: Int
    public var col: Int

    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}

extension Coord {
    public var r: Int { get { row } set { row = newValue } }
    public var c: Int { get { col } set { col = newValue } }

    public init(r: Int, c: Int) {
        self.init(row: r, col: c)
    }

    public init(_ r: Int, _ c: Int) {
        self.init(r: r, c: c)
    }
}

extension Coord: AdditiveArithmetic {    
    public static let zero = Coord(row: 0, col: 0)

    public static func +(lhs: Coord, rhs: Coord) -> Coord {
        Coord(row: lhs.row + rhs.row,
              col: lhs.col + rhs.col)
    }

    public static func -(lhs: Coord, rhs: Coord) -> Coord {
        Coord(row: lhs.row - rhs.row,
              col: lhs.col - rhs.col)
    }
}