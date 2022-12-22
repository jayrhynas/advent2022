import ArgumentParser
import Util

extension Input {
    func readRucksacks() throws -> [Rucksack] {
        try readLines().map {
            Rucksack($0.map { $0 })
        }
    }
}