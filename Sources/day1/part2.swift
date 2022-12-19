import ArgumentParser
import Util

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let calories = try input.readCalories()
        let sums = calories.map { $0.reduce(0, +) }
        let top3 = sums.sorted(by: >).prefix(3)
        print(top3.reduce(0, +))
    }
}