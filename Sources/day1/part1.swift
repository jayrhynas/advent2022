import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let calories = try input.readCalories()
        let sums = calories.map { $0.reduce(0, +) }
        print(sums.max()!)
    }
}