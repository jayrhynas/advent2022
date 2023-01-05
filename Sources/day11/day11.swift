import ArgumentParser

@main
struct Day11: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Part1.self, Part2.self]
    )
}