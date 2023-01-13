import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let instructions = try input.readInstructions()

        let cpu = CPU(instructions: instructions, recording: nil)
        cpu.run()
    }
}
