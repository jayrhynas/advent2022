import ArgumentParser
import struct Util.Input

extension Input {
    static let rangeRegex = #/(\d+)-(\d+),(\d+)-(\d+)/#

    typealias Pair = (first: ClosedRange<Int>, second: ClosedRange<Int>)

    func readRanges() throws -> [Pair] {
        try readLines().compactMap { line -> Pair? in
            guard let match = line.firstMatch(of: Input.rangeRegex) else { return nil }

            let range1 = Int(match.1)! ... Int(match.2)!
            let range2 = Int(match.3)! ... Int(match.4)!

            return (range1, range2)
        }
    }
}