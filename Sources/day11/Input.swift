import ArgumentParser
import Parsing
import struct Util.Input

extension Input {
    static let parser = {
        let id = Parse {
            "Monkey "
            Int.parser()
            ":"
        }

        let items = Parse {
            Whitespace(.horizontal)
            "Starting items: "
            Many {
                Int.parser()
            } separator: {
                ", "
            }
        }

        let operation = Parse {
            Whitespace(.horizontal)
            "Operation: new = old "
            OneOf {
                "+".map { Monkey.OperationType.add }
                "*".map { Monkey.OperationType.mult }
            }
            " "
            OneOf {
                Int.parser().map { Monkey.Operand.value($0) }
                "old".map { Monkey.Operand.old }
            }
        }

        let test = Parse {
            Whitespace(.horizontal)
            "Test: divisible by "
            Int.parser()
        }

        let target = { (type: String) in
            Parse {
                Whitespace(.horizontal)
                "If "
                type
                ": throw to monkey "
                Int.parser()
            }
        }


        let monkey = Parse(Monkey.init) {
            id; "\n"
            items; "\n"
            operation; "\n"
            test; "\n"
            target("true"); "\n"
            target("false")
        }

        return Many { monkey } separator: { "\n\n" }
    }()

    func readMonkeys() throws -> [Monkey] {
        try Self.parser.parse(readString())
    }
}