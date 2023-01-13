import ArgumentParser
import struct Util.Input

struct Part1: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let commands = try input.readCommands()
        let filesystem = Filesystem(from: commands)
        
        let smallDirs = filesystem.root.findDirs(maxFilesize: 100_000)
        
        print(smallDirs.reduce(0) { $0 + $1.size })
    }
}
