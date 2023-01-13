import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let rocks = try input.readRocks()
        
        var grid = Grid(rocks: rocks, hasFloor: true)

        let count = grid.fillWithSand()
        print(count)
    }
}
