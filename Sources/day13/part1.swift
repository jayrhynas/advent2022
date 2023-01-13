import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let pairs = try input.readPairs()

        let sum = pairs.enumerated().compactMap { (idx, pair) in
            if compare(pair.left, pair.right) != .orderedDescending {
                return idx + 1
            } else {
                return nil
            }
        }.reduce(0, +)
        
        print(sum)
    }
}
