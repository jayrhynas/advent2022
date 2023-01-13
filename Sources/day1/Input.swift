import ArgumentParser
import struct Util.Input

extension Input {
    func readCalories() throws -> [[Int]] {
        let calStrings = try readLines().split(separator: "")
        return calStrings.map { $0.map { Int($0)! } }
    }
}