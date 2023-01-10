import ArgumentParser
import Parsing
import Util

extension Input {
    static let parser = {
        var optList: AnyParser<Substring, [Item]>?

        var item: AnyParser<Substring, Item> = OneOf {
            Int.parser().map(Item.val)
            Lazy { optList!.map(Item.list) }
        }.eraseToAnyParser()

        let list = Parse {
            "["
            Many { item } separator: { "," }
            "]"
        }.eraseToAnyParser()
        optList = list

        return Many {
            list
            "\n"
            list
        } separator: {
            "\n\n"
        }
    }()

    func readPairs() throws -> [(left: [Item], right: [Item])] {
        try Self.parser.parse(readString())
    }
}