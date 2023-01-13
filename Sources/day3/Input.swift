import ArgumentParser
import struct Util.Input

extension Input {
    func readRucksacks() throws -> [Rucksack] {
        try readLines().compactMap {
            guard !$0.isEmpty else { return nil }
            return Rucksack($0.map { $0 })
        }
    }
}