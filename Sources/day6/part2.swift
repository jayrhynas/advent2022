import ArgumentParser
import Util

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let lines = try input.readLines()

        for line in lines {
            print(markerPos(length: 14, in: line))
        }
    }
}
