import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let moves = try input.readMoves()

        // Rope.trace = true

        var rope = Rope(at: .zero, length: 10)

        for move in moves {
            rope.move(move)
        }
        
        let visits = Set(rope.path.map { $0.last! })
        print(visits.count)
    }
}
