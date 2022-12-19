import ArgumentParser
import Foundation

public struct Input: ParsableArguments {
    @Argument
    public var filename: String

    public init() {}
    
    public func readString() throws -> String {
        try String(decoding: Data(contentsOf: URL(fileURLWithPath: filename)), as: UTF8.self)
    }

    public func readLines(skipEmpty: Bool = false) throws -> [Substring] {
        try readString().split(separator: "\n", omittingEmptySubsequences: skipEmpty)
    }
}