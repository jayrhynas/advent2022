import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
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
            let fromIdx = move.from - 1
            
            let crates = stacks[fromIdx].suffix(move.count)
            stacks[fromIdx].removeLast(move.count)

            stacks[move.to - 1].append(contentsOf: crates)
        }
    }
}
