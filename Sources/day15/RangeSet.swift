extension ClosedRange where Bound == Int {
    func adjacent(with other: ClosedRange<Bound>) -> Bool {
        let firstUpper = Swift.min(upperBound, other.upperBound)
        let secondLower = Swift.max(lowerBound, other.lowerBound)

        return secondLower - firstUpper == 1
    }
    

    func merged(with other: ClosedRange<Bound>) -> ClosedRange<Bound>? {
        guard overlaps(other) || adjacent(with: other) else {
            return nil
        }

        let lower = Swift.min(lowerBound, other.lowerBound)
        let upper = Swift.max(upperBound, other.upperBound)

        return lower...upper
    }
}

struct RangeSet {
    typealias Element = Int
    
    var ranges: [ClosedRange<Element>] = []

    mutating func insert(_ range: ClosedRange<Element>) {
        var newRanges: [ClosedRange<Element>] = []

        var curRange = range

        for other in self.ranges {
            if let merged = curRange.merged(with: other) {
                curRange = merged
            } else {
                newRanges.append(other)
            }
        }

        newRanges.append(curRange)

        self.ranges = newRanges.sorted { $0.lowerBound < $1.lowerBound }
    }

    func contains(_ value: Element) -> Bool {
        !ranges.allSatisfy { !$0.contains(value) }
    }

    var coveredCount: Int {
        ranges.reduce(0) { sum, range in
            sum + (range.upperBound - range.lowerBound + 1)
        }
    }
}
