import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let rounds = try input.readRounds()
        let score = rounds.map(score(round:)).reduce(0, +)
        print(score)
    }
}
