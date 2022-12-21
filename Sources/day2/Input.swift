import ArgumentParser
import Util

typealias Round = (theirs: Shape, ours: Shape)

extension Input {
    func readRounds() throws -> [Round] {
        try readLines().map {
            let letters = $0.split(separator: " ")
            return (Shape(letters[0])!, Shape(letters[1])!)
        }
    }
}