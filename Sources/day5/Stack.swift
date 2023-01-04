typealias Crate = String
typealias Stack = [Crate]

#if DEBUG
func printStacks(_ stacks: [Stack]) {
    var lines: [[String]] = []

    for i in 0... {
        var allEmpty = true
        var line: [String] = []

        for stack in stacks {
            if i < stack.count {
                allEmpty = false
                line.append("[\(stack[i])]")
            } else {
                line.append("   ")
            }
        }

        if allEmpty {
            break
        }

        lines.append(line)
    }

    for line in lines.reversed() {
        print(line.joined(separator: " "))
    }

    print(lines[0].indices.map { " \($0 + 1) " }.joined(separator: " "))
}
#endif