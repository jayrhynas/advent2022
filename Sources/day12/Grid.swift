struct Grid {
    let cells: [[Cell]]
    
    let start: Coord
    let end: Coord

    init(cells: [[Cell]]) {
        self.cells = cells

        var start: Coord!
        var end: Coord!

        for (r, row) in cells.enumerated() {
            for (c, cell) in row.enumerated() {
                if cell.special == .start {
                    start = Coord(r: r, c: c)
                } else if cell.special == .end {
                    end = Coord(r: r, c: c)
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
        var path: [Coord: Direction] = [end: .up]

        var cur = end
        while let (_, prevDir) = self[cur]?.previous {
            let coord = cur.move(prevDir)
            path[coord] = prevDir.opposite
            cur = coord
        }

        return cells.enumerated().map { (r, row) in
            row.enumerated().map { (c, cell) in
                if cell.special != nil {
                    return cell.description
                }

                if let dir = path[Coord(r: r, c: c)] {
                    return dir.rawValue
                }

                return "."
            }.joined(separator: "") 
        }.joined(separator: "\n")
    }
}
