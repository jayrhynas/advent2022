import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let rocks = try input.readRocks()
        
        var grid = Grid(rocks: rocks)

        // print(grid)

        var count = 0
        while true {
            let settled = grid.generateSand()
            // print(grid)

            if !settled {
                break
            }

            count += 1
        }

        // print(grid)
        print(count)
    }
}
