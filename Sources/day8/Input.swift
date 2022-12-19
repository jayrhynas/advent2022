import Util

extension Input {
    func readGrid() throws -> Grid {
        let values = try readLines().map { $0.map { Int(String($0))! } }

        return Grid(values.flatMap { $0.map { Tree(height: $0) } }, 
                    size: (values.count, values[0].count))
    }
}