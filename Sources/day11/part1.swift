import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let monkeys = try input.readMonkeys()
        print(monkeyBusiness(monkeys, rounds: 20))
    }

    func monkeyBusiness(_ monkeys: [Monkey], rounds: Int) -> Int {
        for _ in 1...rounds {
            for monkey in monkeys {
                while let item = monkey.items.first {
                    monkey.items.removeFirst()

                    let (newItem, target) = monkey.inspect(item)
                    monkeys[target].items.append(newItem)
                }
            }
        }

        let max2 = monkeys.sorted { $0.inspectionCount < $1.inspectionCount }.suffix(2)

        return max2.map(\.inspectionCount).reduce(1, *)
    }
}
