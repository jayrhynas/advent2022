import ArgumentParser
import Util

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let instructions = try input.readInstructions()

        let cpu = CPU()

        cpu.run(instructions)

        print(cpu.signalStrengths.reduce(0, +))
    }
}
