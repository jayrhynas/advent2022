import ArgumentParser
import struct Util.Coord
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        var grid = try input.readGrid()

        var maxScore = 0

        for r in grid.rows {
            for c in grid.cols {
                let loc = Coord(r, c)

                var score = 1
                for dir in Dir.allCases {
                    score *= grid.distance(from: loc, dir: dir)
                }

                maxScore = max(score, maxScore)
            }
        }

        print(maxScore)
    }
}

extension Dir {
    var movement: Coord {
        switch self {
        case .n: return Coord(-1,  0)
        case .e: return Coord( 0,  1)
        case .s: return Coord( 1,  0)
        case .w: return Coord( 0, -1)
        }
    }
}

private extension Grid {
    mutating func distance(from loc: Coord, dir: Dir) -> Int {
        guard let startTree = self[loc] else { return 0 }

        var loc = loc

        var count = 0

        while true {
            loc.r += dir.movement.r
            loc.c += dir.movement.c

            guard let tree = self[loc] else { break }

            count += 1

            if tree.height >= startTree.height {
                break
            }
        }

        return count
    }
}