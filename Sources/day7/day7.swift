import ArgumentParser

@main
struct Day7: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Part1.self, Part2.self]
    )
}