import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let monkeys = try input.readMonkeys()
        print(monkeyBusiness(monkeys, rounds: 20))
    }
}
