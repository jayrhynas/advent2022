func markerPos<S: StringProtocol>(length: Int, in line: S) -> Int {
    for endIdx in line.indices.dropFirst(length) {
        let startIdx = line.index(endIdx, offsetBy: -length)
        let chars = Set(line[startIdx..<endIdx])
        
        if chars.count == length {
            return line.distance(from: line.startIndex, to: endIdx)
        }
    }

    return -1
}