import ArgumentParser
import Parsing
import struct Util.Coord
import struct Util.Input

extension Input {
    static let parser = Many {
        Parse(Rock.init) {
            Many {
                Parse {
                    Int.parser()
                    ","
                    Int.parser()
                }.map { (c, r) in
                    Coord(r, c)
                }
            } separator: {
                Whitespace(.horizontal)
                "->"
                Whitespace(.horizontal)
            }
        }
    } separator: {
        Whitespace(1, .vertical)
    }

    func readRocks() throws -> [Rock] {
        try Self.parser.parse(readString())
    }
}