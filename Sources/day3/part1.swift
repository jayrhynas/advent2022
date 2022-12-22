import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let sacks = try input.readRucksacks()

        let sum = sacks
            .map(error(in:))
            .map(Rucksack.priority(of:))
            .reduce(0, +)

        print(sum)
    }

    func error(in sack: Rucksack) -> Character {
        sack.compartment1.intersection(sack.compartment2).first!
    }
}
