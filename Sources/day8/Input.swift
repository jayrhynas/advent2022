import ArgumentParser
import Foundation

struct Input: ParsableArguments {
    @Argument
    var filename: String

    func readInput() throws -> Grid {
        let input = try String(decoding: Data(contentsOf: URL(fileURLWithPath: filename)), as: UTF8.self)
        let values = input.split(separator: "\n").map { $0.map { Int(String($0))! } }

        return Grid(values.flatMap { $0.map { Tree(height: $0) } }, 
                    size: (values.count, values[0].count))
    }
}