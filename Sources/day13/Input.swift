import ArgumentParser
import Parsing
import struct Util.Input

extension Input {
    static let parsers = {
        var optList: AnyParserPrinter<Substring, [Item]>?

        var item: AnyParserPrinter<Substring, Item> = OneOf {
            Int.parser().map(.case(Item.val))
            Lazy { optList!.map(.case(Item.list)) }
        }.eraseToAnyParserPrinter()

        let list = ParsePrint {
            "["
            Many { item } separator: { "," }
            "]"
        }.eraseToAnyParserPrinter()
        optList = list

        return (
            item: item,
            pairs: Many {
                    list
                    "\n"
                    list
                } separator: {
                    "\n\n"
                },
            packets: Many {
                    list
                } separator: {
                    Prefix { $0 == "\n" }
                }
        )
    }()

    func readPairs() throws -> [(left: [Item], right: [Item])] {
        try Self.parsers.pairs.parse(readString())
    }

    func readPackets() throws -> [[Item]] {
        try Self.parsers.packets.parse(readString())
    }
}