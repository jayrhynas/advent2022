import ArgumentParser
import Util

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let grid = try input.readGrid()

        print(findShortestPath(in: grid))
    }
}

// dijkstra's aglorithm
private func findShortestPath(in grid: Grid) -> Int {
    // mark `end` as distance 0 and `start` as distance nil
    // (`start` is no longer special since we're looking for any starting point)

    grid.end.dist = 0
    grid.start.dist = nil

    var unseen = Set(grid.cells.flatMap { $0 })

    while let cur = unseen.filter({ $0.dist != nil }).min(by: { $0.dist! < $1.dist! }) {
        if cur.height == 0 {
            return cur.dist!
        }

        for dir in Direction.allCases {
            let coord = cur.pos.move(dir)
            
            guard let other = grid[coord],
                other.height >= cur.height - 1,
                unseen.contains(other)
            else {
                continue
            }

            let newDist = cur.dist! + 1

            if let oldDist = other.dist, oldDist <= newDist {
                continue
            }

            other.previous = (cur, dir.opposite)
            other.dist = newDist
        }

        // print(grid.backtrackDescription + "\n")

        unseen.remove(cur)
    }

    fatalError()
}
