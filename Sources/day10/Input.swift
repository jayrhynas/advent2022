import ArgumentParser
import Parsing
import Util

extension Input {
    static let parser = Many {
        OneOf {
            "noop".map { Instruction.noop }
            Parse { "addx "; Int.parser() }.map { Instruction.addx($0) }
        }
    } separator: {
        "\n"
    }

    func readInstructions() throws -> [Instruction] {
        try Self.parser.parse(readString())
    }
}