import ArgumentParser
import struct Util.Input

extension Input {
    func readRounds() throws -> [Round] {
        try readLines().map {
            let letters = $0.split(separator: " ")
            return (Shape(letters[0])!, Shape(letters[1])!)
        }
    }

    func readOutcomes() throws -> [(move: Shape, outcome: Outcome)] {
        try readLines().map {
            let letters = $0.split(separator: " ")
            return (Shape(letters[0])!, Outcome(letters[1])!)
        }
    }
}