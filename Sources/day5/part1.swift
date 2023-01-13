import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        var (stacks, moves) = try input.read()
        
        apply(moves, to: &stacks)

        let topCrates = stacks.map {
            $0.last ?? ""
        }

        print(topCrates.joined(separator: ""))
    }

    func apply(_ moves: [Move], to stacks: inout [Stack]) {
        for move in moves {
            for _ in 0..<move.count {
                let crate = stacks[move.from - 1].popLast()!
                stacks[move.to - 1].append(crate)
            }
        }
    }
}
