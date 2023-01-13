import struct Util.Coord

struct Grid {
    enum Entity: String {
        case source = "+"
        case rock   = "#"
        case sand   = "o"
        case air    = "."
    }

    let source: Coord
    var cells: [Coord: Entity] = [:]

    let bounds: (row: ClosedRange<Int>, col: ClosedRange<Int>)

    init(rocks: [Rock], source: Coord = .init(row: 0, col: 500)) {
        self.source = source
        cells[source] = .source

        var minCol = Int.max
        var maxCol = Int.min
        var maxRow = Int.min

        func updateBounds(with coord: Coord) {
            minCol = min(minCol, coord.c)
            maxCol = max(maxCol, coord.c)
            maxRow = max(maxRow, coord.r)
        }

        for rock in rocks {
            updateBounds(with: rock.coords.first!)

            for (prev, next) in zip(rock.coords, rock.coords.dropFirst()) {
                updateBounds(with: next)

                if prev.row == next.row {
                    for c in min(prev.col, next.col)...max(prev.col, next.col) {
                        cells[Coord(prev.row, c)] = .rock
                    }
                } else if prev.col == next.col {
                    for r in min(prev.row, next.row)...max(prev.row, next.row) {
                        cells[Coord(r, prev.col)] = .rock
                    }
                }
            }
        }

        self.bounds = (0...maxRow, minCol...maxCol)
    }

    subscript(_ coord: Coord) -> Entity {
        get { cells[coord, default: .air] }
        set { cells[coord] = newValue }
    }

    mutating func generateSand() -> Bool {
        var sand = source

        let movements = [0, -1, 1].map { Coord(1, $0) }

        move: while true {
            for move in movements {
                let next = sand + move

                if self[next] == .air {
                    sand = next

                    if next.row == bounds.row.upperBound {
                        return false
                    }

                    continue move
                } else {
                    continue
                }
            }
            
            self[sand] = .sand

            return true
        }
    }
}

extension Grid: CustomStringConvertible {
    var description: String {    
        var str = ""

        for r in bounds.row {
            for c in bounds.col {
                let entity = self[Coord(r, c)]
                print(entity.rawValue, terminator: "", to: &str)
            }
            print("", to: &str)
        }

        return str
    }
}