import ArgumentParser
import struct Util.Coord
import struct Util.Input

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