import ArgumentParser
import Util

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let sacks = try input.readRucksacks()

        let sum = sacks
            .chunked(into: 3)
            .map(badge(for:))
            .map(Rucksack.priority(of:))
            .reduce(0, +)

        print(sum)
    }

    func badge(for sacks: ArraySlice<Rucksack>) -> Character {
        let combined = sacks.map { 
            $0.compartment1.union($0.compartment2) 
        }

        let intersection: Set<Character>? = combined.reduce(nil) { common, sack in
            guard var common else {
                return sack
            }
            
            common.formIntersection(sack)

            return common
        }

        return intersection!.first!
    }
}

extension Array {
    func chunked(into size: Int) -> [ArraySlice<Element>] {
        stride(from: 0, to: count, by: size).map {
            self[$0 ..< Swift.min($0 + size, count)]
        }
    }
}