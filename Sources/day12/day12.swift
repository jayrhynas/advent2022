import ArgumentParser

@main
struct Day12: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Part1.self, Part2.self]
    )
}