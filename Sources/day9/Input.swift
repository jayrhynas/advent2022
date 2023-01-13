import ArgumentParser
import Parsing
import struct Util.Input

extension Input {
    static let parser = Many {
        Direction.parser()
        Whitespace()
        Int.parser()
    } separator: {
        "\n"
    }

    func readMoves() throws -> [Move] {
        try Self.parser.parse(readString())
    }
}