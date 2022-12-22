import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let sacks = try input.readRucksacks()

        let sum = sacks
            .map(error(in:))
            .map(priority(of:))
            .reduce(0, +)

        print(sum)
    }

    func error(in sack: Rucksack) -> Character {
        sack.compartment1.intersection(sack.compartment2).first!
    }

    private static let a = Character("a").asciiValue!
    private static let A = Character("A").asciiValue!

    func priority(of character: Character) -> Int {
        let val = character.asciiValue!
        if val >= Self.a {
            return Int(val - Self.a + 1)
        } else {
            return Int(val - Self.A + 27)
        }
    }
}
