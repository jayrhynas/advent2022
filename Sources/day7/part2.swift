import ArgumentParser
import Util

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        let commands = try input.readCommands()
        let filesystem = Filesystem(from: commands)
        
        let capacity = 70000000
        let required = 30000000

        let free = capacity - filesystem.root.size
        let toDelete = required - free

        let dirToDelete = filesystem.root.smallestDir(minFilesize: toDelete)

        print(dirToDelete.size)
    }
}
