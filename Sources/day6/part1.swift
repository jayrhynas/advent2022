import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let lines = try input.readLines()

        for line in lines {
            print(markerPos(in: line))
        }
    }

    func markerPos<S: StringProtocol>(in line: S) -> Int {
        for endIdx in line.indices.dropFirst(4) {
            let startIdx = line.index(endIdx, offsetBy: -4)
            let chars = Set(line[startIdx..<endIdx])
            
            if chars.count == 4 {
                return line.distance(from: line.startIndex, to: endIdx)
            }
        }

        return -1
    }
}
