class Monkey {
    enum Operand {
        case old
        case value(Int)
    }

    enum OperationType {
        case add
        case mult
    }

    typealias Operation = (op: OperationType, val: Operand)

    let id: Int
    var items: [Int]
    let operation: Operation
    let test: Int
    let targets: (true: Int, false: Int)

    var inspectionCount = 0

    init(id: Int, items: [Int], operation: Operation, test: Int, trueTarget: Int, falseTarget: Int) {
        self.id = id
        self.items = items
        self.operation = operation
        self.test = test
        self.targets = (trueTarget, falseTarget)
    }

    func inspect(_ item: Int, relief: Int = 3) -> (Int, Int) {
        inspectionCount += 1
        
        var level = item

        switch operation {
        case (.add, .old):  level += level
        case (.mult, .old): level *= level

        case (.add, .value(let val)):  level += val
        case (.mult, .value(let val)): level *= val
        }

        level /= relief

        if level % test == 0 {
            return (level, targets.true)
        } else {
            return (level, targets.false)
        }
    }
}

extension Monkey: CustomStringConvertible {
    var description: String {
        """
        Monkey \(id):
          Items: \(items.map { "\($0)" }.joined(separator: ", "))
          Op: \(operation.op) \(operation.val)
          Test: \(test)
            true: \(targets.true)
            false: \(targets.false)
        """
    }
}


func monkeyBusiness(_ monkeys: [Monkey], rounds: Int, relief: Int = 3) -> Int {
    let mod = monkeys.map(\.test).reduce(1, *)

    for _ in 1...rounds {
        for monkey in monkeys {
            while let item = monkey.items.first {
                monkey.items.removeFirst()

                var (newItem, target) = monkey.inspect(item, relief: relief)
                newItem = newItem % mod
                monkeys[target].items.append(newItem)
            }
        }
    }

    let max2 = monkeys.sorted { $0.inspectionCount < $1.inspectionCount }.suffix(2)

    return max2.map(\.inspectionCount).reduce(1, *)
}
