import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let outcomes = try input.readOutcomes()
        let rounds = outcomes.map { move, outcome in
            let ourMove: Shape
            switch (move, outcome) {
            case (.rock, .win):  ourMove = .paper
            case (.rock, .lose): ourMove = .scissors
            case (.rock, .tie):  ourMove = .rock
            case (.paper, .win):  ourMove = .scissors
            case (.paper, .lose): ourMove = .rock
            case (.paper, .tie):  ourMove = .paper
            case (.scissors, .win):  ourMove = .rock
            case (.scissors, .lose): ourMove = .paper
            case (.scissors, .tie):  ourMove = .scissors
            }

            return (move, ourMove)
        }

        let score = rounds.map(score(round:)).reduce(0, +)
        print(score)
    }
}
