import ArgumentParser
import Util

extension Input {
    func readGrid() throws -> Grid {
        let cells = try readLines().enumerated().map { (r, line) in
            line.enumerated().map { (c, letter) in 
                Cell(letter, pos: Coord(r: r, c: c))
            }
        }
        return Grid(cells: cells)
    }
}