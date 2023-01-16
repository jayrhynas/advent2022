import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let coords = try input.readCoords()

        let grid = Grid(entities: coords)

        // print(grid)
        
        let beacon = grid.findMissingBeacon(in: 0...4000000)!
        print(beacon.x * 4000000 + beacon.y)
    }
}
