import ArgumentParser
import Util

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let ranges = try input.readRanges()

        let count = ranges.reduce(0) { sum, pair in
            sum + (pair.first.overlaps(pair.second) ? 1 : 0)
        }

        print(count)
    }
}
