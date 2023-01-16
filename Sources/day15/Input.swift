import ArgumentParser
import Parsing
import struct Util.Coord
import struct Util.Input

extension Input {
    static let parser = Many {
        Parse {
            "Sensor at x="
            Int.parser()
            ", y="
            Int.parser()
            ": closest beacon is at x="
            Int.parser()
            ", y="
            Int.parser()
        }.map { (sx, sy, bx, by) in
            (sensor: Coord(y: sy, x: sx),
             beacon: Coord(y: by, x: bx))
        }
    } separator: {
        Whitespace(1, .vertical)
    }

    func readCoords() throws -> [(sensor: Coord, beacon: Coord)] {
        try Self.parser.parse(readString())
    }
}