import struct Util.Coord

enum Dir: String, CaseIterable {
    case n, e, s, w
}

struct Grid {
    private (set) var trees: [Tree]

    let size: (rows: Int, cols: Int)
    let rows: Range<Int>
    let cols: Range<Int>

    init(_ trees: [Tree], size: (rows: Int, cols: Int)) {
        self.trees = trees
        self.size = size
        self.rows = 0..<size.rows
        self.cols = 0..<size.cols
    }

    subscript(_ coord: Coord) -> Tree? {
        get {
            guard rows.contains(coord.r), cols.contains(coord.c) else { return nil }
            return trees[coord.r * size.cols + coord.c]
        }
        set {
            guard rows.contains(coord.r), cols.contains(coord.c), let val = newValue else { return }
            trees[coord.r * size.cols + coord.c] = val
        }
    }
}
