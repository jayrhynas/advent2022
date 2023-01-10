# Advent2022

My solutions for [Advent of Code 2022](https://adventofcode.com/2022/), written in Swift.

# Structure

Each day is implemented as a target in this Swift Package, and each part is a subcommand of the day. [ArgumentParser](https://github.com/apple/swift-argument-parser) is used for handling subcommands and inputs.

Source files for each day are found under `Sources/day<n>/` and input files are in `Sources/day<n>/inputs/`.

Individual parts can be run with:

```
swift run day<n> part<n> Sources/day<n>/inputs/input.txt
```

# Development

`./makeDay <day>` can be used to generate scaffolding files and update `Package.swift` with the new day's target.

`./watchDay <day> <part> <input>` can be used to watch the source directory and re-run the day when files change.
