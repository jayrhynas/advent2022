import ArgumentParser

@main
struct Day15: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Part1.self, Part2.self]
    )
}