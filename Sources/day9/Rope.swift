struct Rope {
    static var trace = false

    var head: Coord
    var tail: Coord

    init(at start: Coord) {
        head = start
        tail = start

        updatePath()
    }

    mutating func move(_ move: Move) {
        let (direction, count) = move

        #if DEBUG
        if Self.trace {
            print("== \(direction.rawValue) \(count) ==\n")
        }
        #endif

        for _ in 0..<count {
            head += direction.movement

            let dist = head - tail

            func check(_ main: WritableKeyPath<Coord, Int>) {
                let mainDist = dist[keyPath: main]

                guard abs(mainDist) > 1 else { return }

                let sign = mainDist > 0 ? 1 : -1
                tail[keyPath: main] = head[keyPath: main] - sign

                let other = main == \.row ? \Coord.col : \Coord.row
                let otherDist = dist[keyPath: other]

                if otherDist > 0 {
                    tail[keyPath: other] += 1
                } else if otherDist < 0 {
                    tail[keyPath: other] -= 1
                }
            }
            
            check(\.row)
            check(\.col)

            updatePath()

            #if DEBUG
            if Self.trace {
                printGrid()
            }
            #endif
        }
    }

    private(set) var path: [(head: Coord, tail: Coord)] = []

    private mutating func updatePath() {
        path.append((head, tail))
    }

    #if DEBUG
    func printGrid() {
        guard let start = path.first else { return }

        var (minRow, maxRow) = (Int.max, Int.min)
        var (minCol, maxCol) = (Int.max, Int.min)

        for pos in path {
            minRow = min(minRow, pos.head.row, pos.tail.row)
            maxRow = max(maxRow, pos.head.row, pos.tail.row)
            minCol = min(minCol, pos.head.col, pos.tail.col)
            maxCol = max(maxCol, pos.head.col, pos.tail.col)
        }

        for r in minRow...maxRow {
            for c in minCol...maxCol {
                let pos = Coord(row: r, col: c)

                if pos == head {
                    print("H", terminator: "")
                } else if pos == tail {
                    print("T", terminator: "")
                } else if pos == start.head {
                    print("s", terminator: "")
                } else {
                    print(".", terminator: "")
                }
            }
            print("")
        }
        print("")
    }
    #endif
}

extension Rope: CustomStringConvertible {
    var description: String {
        "H(\(head.row),\(head.col)) T(\(tail.row),\(tail.col))"
    }
}