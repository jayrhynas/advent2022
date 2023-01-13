import ArgumentParser
import Parsing
import struct Util.Input

extension Input {
    static let parser = {
        // cd
        let cdCommand = Parse {
            "$ cd "
            Prefix { $0 != "\n" }
        }.map { target in
            switch target {
            case "/":  return Command.cd(.root)
            case "..": return Command.cd(.up)
            default: return Command.cd(.down(String(target)))
            }
        }

        // ls
        let dirListing = Parse(Command.Listing.dir) {
            "dir "
            Prefix { $0 != "\n" }.map(String.init)
        }

        let fileListing = Parse(Command.Listing.file) {
            Int.parser()
            " "
            Prefix { $0 != "\n" }.map(String.init)
        }

        let lsCommand = Parse {
            "$ ls\n"
            Many(1...) {
                OneOf {
                    dirListing
                    fileListing
                }
            } separator: {
                "\n"
            }
        }.map { listings in
            Command.ls(listings)
        }

        // all commands
        return Many(1...) {
            OneOf {
                cdCommand
                lsCommand
            }
        } separator: { "\n" }
    }()

    func readCommands() throws -> [Command] {
        let input = try readString()
        return try Self.parser.parse(input)
    }
}