struct Rope {
    static var trace = false

    var knots: [Coord]

    init(at start: Coord, length: Int = 2) {
        knots = .init(repeating: start, count: length)

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
            knots[0] += direction.movement

            for idx in knots.indices.dropFirst() {
                let prev = knots[idx - 1]

                var cur: Coord {
                    get { knots[idx] }
                    set { knots[idx] = newValue }
                }


                let dist = prev - cur

                func check(_ main: WritableKeyPath<Coord, Int>) -> Bool {
                    let mainDist = dist[keyPath: main]

                    guard abs(mainDist) > 1 else { return false }

                    let sign = mainDist > 0 ? 1 : -1
                    cur[keyPath: main] = prev[keyPath: main] - sign

                    let other = main == \.row ? \Coord.col : \Coord.row
                    let otherDist = dist[keyPath: other]

                    if otherDist > 0 {
                        cur[keyPath: other] += 1
                    } else if otherDist < 0 {
                        cur[keyPath: other] -= 1
                    }

                    return true
                }
                
                let _ = check(\.row) || check(\.col)
            }

            updatePath()

            #if DEBUG
            if Self.trace {
                printGrid()
            }
            #endif
        }
    }

    private(set) var path: [[Coord]] = []

    private mutating func updatePath() {
        path.append(knots)
    }

    #if DEBUG
    func printGrid() {
        guard let start = path.first else { return }

        var (minRow, maxRow) = (knots.map(\.row).min()!, knots.map(\.row).max()!)
        var (minCol, maxCol) = (knots.map(\.col).min()!, knots.map(\.col).max()!)

        for knots in path {
            minRow = min(minRow, knots.map(\.row).min()!)
            maxRow = max(maxRow, knots.map(\.row).max()!)
            minCol = min(minCol, knots.map(\.col).min()!)
            maxCol = max(maxCol, knots.map(\.col).max()!)
        }

        for r in minRow...maxRow {
            for c in minCol...maxCol {
                let pos = Coord(row: r, col: c)

                if pos == knots[0] {
                    print("H", terminator: "")
                } else if let idx = knots.firstIndex(of: pos) {
                    print(idx, terminator: "")
                } else if pos == start[0] {
                    print("s", terminator: "")
                } else {
                    print(".", terminator: "")
                }
            }
            print("")
        }
        print("")
    }

    func printTailPath() {
        guard let start = path.first else { return }

        var (minRow, maxRow) = (knots.map(\.row).min()!, knots.map(\.row).max()!)
        var (minCol, maxCol) = (knots.map(\.col).min()!, knots.map(\.col).max()!)

        for knots in path {
            minRow = min(minRow, knots.map(\.row).min()!)
            maxRow = max(maxRow, knots.map(\.row).max()!)
            minCol = min(minCol, knots.map(\.col).min()!)
            maxCol = max(maxCol, knots.map(\.col).max()!)
        }

        let tails = Set(path.map { $0.last! })

        for r in minRow...maxRow {
            for c in minCol...maxCol {
                let pos = Coord(row: r, col: c)

                if pos == start[0] {
                    print("s", terminator: "")
                } else if tails.contains(pos) {
                    print("#", terminator: "")
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
