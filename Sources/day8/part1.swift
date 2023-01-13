import ArgumentParser
import struct Util.Coord
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        var grid = try input.readGrid()

        for r in grid.rows {
            grid.checkVisible(dir: .w, rows: [r], cols: grid.cols)
            grid.checkVisible(dir: .e, rows: [r], cols: grid.cols.reversed())
        }

        for c in grid.cols {
            grid.checkVisible(dir: .n, rows: grid.rows, cols: [c])
            grid.checkVisible(dir: .s, rows: grid.rows.reversed(), cols: [c])
        }

        let visible = grid.trees.reduce(0) { total, tree in
            total + (tree.isVisible ? 1 : 0)
        }
        print(visible)
    }

    
}

private extension Grid {
    mutating func checkVisible<Rows, Cols>(dir: Dir, rows: Rows, cols: Cols) where Rows: Collection, Rows.Element == Int, Cols: Collection, Cols.Element == Int {
        var maxHeight: Int = -1
        for r in rows {
            for c in cols {
                let coord = Coord(r, c)

                guard let height = self[coord]?.height else { continue }
                self[coord]?.visible[dir] = height > maxHeight
                maxHeight = max(height, maxHeight)
            }
        }
    }
}