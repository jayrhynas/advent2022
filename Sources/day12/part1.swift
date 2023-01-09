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
func findShortestPath(in grid: Grid) -> Int {
    var queue = [grid.start][...]

    while let cur = queue.popFirst() {
        let cur = (coord: cur, cell: grid[cur]!)

        for dir in Direction.allCases {
            let coord = cur.coord.move(dir)
            
            guard let other = grid[coord] else { 
                continue
            }

            guard other.height <= cur.cell.height + 1 else {
                continue
            }

            let seen = other.dist != nil

            if let dist = other.dist, dist <= cur.cell.dist! {
                continue
            }

            other.previous = (cur.cell, dir.opposite)
            other.dist = cur.cell.dist! + 1

            // print(grid.backtrackDescription + "\n")

            if !seen {
                queue.append(coord)
            }
        }
    }

    // print(grid.pathDescription)

    return grid[grid.end]!.dist!
}
