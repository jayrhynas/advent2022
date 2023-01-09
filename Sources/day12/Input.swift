import ArgumentParser
import Util

extension Input {
    func readGrid() throws -> Grid {
        let cells = try readLines().map { $0.map { Cell($0) } }
        return Grid(cells: cells)
    }
}