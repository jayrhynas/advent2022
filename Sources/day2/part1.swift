import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let rounds = try input.readRounds()
        let score = rounds.map(score(round:)).reduce(0, +)
        print(score)
    }

    func score(round: Round) -> Int {
        var score = 0

        switch round.ours {
        case .rock:     score += 1
        case .paper:    score += 2
        case .scissors: score += 3
        }

        switch round {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): score += 6
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): score += 3
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper): score += 0
        }
        return score
    }
}