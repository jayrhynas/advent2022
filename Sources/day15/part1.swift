import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let coords = try input.readCoords()

        let grid = Grid(entities: coords)

        // print(grid)

        print(grid.countNonBeacons(y: 2000000))
    }
}
