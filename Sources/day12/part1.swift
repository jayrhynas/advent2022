import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let grid = try input.readGrid()

        print(findShortestPath(in: grid))
    }
}

// breadth-first-seach + dynamic programming
private func findShortestPath(in grid: Grid) -> Int {
    var queue = [grid.start][...]

    while let cur = queue.popFirst() {
        for dir in Direction.allCases {
            let coord = cur.pos + dir.movement
            
            guard let other = grid[coord] else { 
                continue
            }

            guard other.height <= cur.height + 1 else {
                continue
            }

            let seen = other.dist != nil

            if let dist = other.dist, dist <= cur.dist! {
                continue
            }

            other.previous = (cur, dir.opposite)
            other.dist = cur.dist! + 1

            // print(grid.backtrackDescription + "\n")

            if !seen {
                queue.append(other)
            }
        }
    }

    // print(grid.pathDescription)

    return grid[grid.end.pos]!.dist!
}
