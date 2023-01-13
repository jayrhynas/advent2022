import struct Util.Coord

struct Grid {
    let cells: [[Cell]]
    
    let start: Cell
    let end: Cell

    init(cells: [[Cell]]) {
        self.cells = cells

        var start: Cell!
        var end: Cell!

        for row in cells {
            for cell in row {
                if cell.special == .start {
                    start = cell
                } else if cell.special == .end {
                    end = cell
                }

                if start != nil && end != nil {
                    break
                }
            }
        }

        self.start = start
        self.end = end
    }

    subscript(_ coord: Coord) -> Cell? {
        guard cells.indices.contains(coord.row) else {
            return nil
        }

        let row = cells[coord.row]
        guard row.indices.contains(coord.col) else {
            return nil
        }

        return row[coord.col]
    }
}

extension Grid {
    var heightDescription: String {
        cells.map { 
            $0.map(\.description).joined(separator: "") 
        }.joined(separator: "\n")
    }

    var backtrackDescription: String {
        cells.map {
            $0.map {
                $0.special != nil ? $0.description : ($0.previous?.1.rawValue ?? ".")
            }.joined(separator: "")
        }.joined(separator: "\n")
    }

    var pathDescription: String {
        var path: [Coord: Direction] = [end.pos: .up]

        var cur = end
        while let (_, prevDir) = cur.previous {
            let coord = cur.pos + prevDir.movement
            path[coord] = prevDir.opposite
            cur = self[coord]!
        }

        return cells.map { row in
            row.map { cell in
                if cell.special != nil {
                    return cell.description
                }

                if let dir = path[cell.pos] {
                    return dir.rawValue
                }

                return "."
            }.joined(separator: "") 
        }.joined(separator: "\n")
    }
}
