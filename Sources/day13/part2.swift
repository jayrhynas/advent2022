import ArgumentParser
import struct Util.Input

struct Part2: ParsableCommand {
    @OptionGroup
    var input: Input

    mutating func run() throws {
        var packets = try input.readPackets().map { Item.list($0) }

        let d1 = Item.list([.list([.val(2)])])
        let d2 = Item.list([.list([.val(6)])])

        packets.append(d1)
        packets.append(d2)

        packets.sort()

        // for packet in packets {
        //     try print(Input.parsers.item.print(packet))
        // }
        
        let i1 = packets.firstIndex(where: { $0 == d1 || $0 == d2 })! + 1
        let i2 = packets.dropFirst(i1 + 1).firstIndex(where: { $0 == d1 || $0 == d2 })! + 1

        print(i1 * i2)
    }
}
