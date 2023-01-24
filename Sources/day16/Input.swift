import ArgumentParser
import Parsing
import struct Util.Input

extension Input {
    static let parser = Many {
        Parse(Graph.Node.init) {
            "Valve "
            Prefix(2).map { String($0) }
            " has flow rate="
            Int.parser()
            Skip {
                "; "
                OneOf {
                    "tunnels lead to valves "
                    "tunnel leads to valve "
                }
            }
            Many {
                Prefix(2).map { String($0) }
            } separator: {
                ", "
            }
        }
    } separator: {
        Whitespace(1, .vertical)
    }

    func readValves() throws -> [Graph.Node] {
        try Self.parser.parse(readString())
    }
}