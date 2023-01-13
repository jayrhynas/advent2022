import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let instructions = try input.readInstructions()

        let cpu = CPU(instructions: instructions, crt: nil)
        cpu.run()
        print(cpu.signalStrengths.reduce(0, +))
    }
}
