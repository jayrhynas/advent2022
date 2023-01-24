import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let valves = try input.readValves()
        let graph = Graph(valves)

        print(graph.findMaxPressure(minutes: 26, agents: 2))
    }
}
