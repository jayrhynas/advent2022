import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let ranges = try input.readRanges()

        let count = ranges.reduce(0) { sum, pair in
            let doesContain = pair.first.contains(pair.second) 
                           || pair.second.contains(pair.first)
                           
            return sum + (doesContain ? 1 : 0)
        }

        print(count)
    }
}

extension ClosedRange where Bound: Comparable {
    func contains(_ other: ClosedRange) -> Bool {
        self.lowerBound <= other.lowerBound && self.upperBound >= other.upperBound
    }
}