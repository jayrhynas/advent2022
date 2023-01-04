import ArgumentParser
import Foundation
import Parsing
import Util

extension Input {
    static let parser = {
        let crate = Parse {
            "["
            CharacterSet.letters
            "]"
        }.map { Optional($0) }

        let blank = "   ".map { 
            Optional<Substring>.none 
        }

        let crates = Parse {
            Many(1...) {
                Many(1...) {
                    OneOf { 
                        crate
                        blank
                    }
                } separator: {
                    " "
                }
            } separator: {
                "\n"
            }
            Skip {
                "\n "
                Many { Int.parser() } separator: { Whitespace() }
                Optionally { " " }
            }
        }

        let moves = Parse {
            Many(1...) {
                "move "
                Int.parser()
                " from "
                Int.parser()
                " to "
                Int.parser()
            } separator: {
                "\n"
            }
        }

        return Parse {
            crates
            Whitespace()
            moves
        }
    }()

    func read() throws -> ([Stack], [Move]) {
        let str = try readString()

        let (rows, moves) = try Self.parser.parse(str)

        let stacks = rows.reversed().transpose().map { stack in
            stack.compactMap { label -> Crate? in
                guard let label else { return nil }
                return Crate(label)
            }
        }

        return (stacks, moves)
    }
}

extension Array {
    func transpose<E>() -> [[E]] where Element == [E] {
        guard let first = self.first else { return [] }

        #if DEBUG
        for arr in self.dropFirst() {
            assert(arr.count == first.count)
        }
        #endif

        return first.indices.map { index in
            self.map { $0[index] }
        }
    }
}