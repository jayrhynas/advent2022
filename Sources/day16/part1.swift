import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let valves = try input.readValves()
        let graph = Graph(valves)

        print(graph.findMaxPressure())
    }
}
