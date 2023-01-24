struct Graph {
    struct Node {
        let label: String
        let rate: Int
        let connections: [String]
    }

    let nodes: [Node]
    let distances: DistanceDict

    init(_ nodes: [Node]) {
        self.nodes = nodes

        // calculate shortest distance from a node to any other node
        var distances = DistanceDict()

        // distance from node to itself is 0, from node to a connection is 1
        for node in nodes {
            let label = node.label
            distances[label, label] = 0

            for other in node.connections {
                distances[label, other] = 1
            }
        }

        let labels = nodes.map(\.label).sorted()

        // for all permutations of sets of 3 nodes:
        for k in labels {
            for i in labels {
                for j in labels {
                    // compare known distance from i to j with distance from i to k, then k to j                    
                    guard let distI_K = distances[i, k], let distK_J = distances[k, j] else {
                        // if no known distance from i to k and k to j, then skip
                        continue
                    }

                    let distI_K_J = distI_K + distK_J

                    if distI_K_J < distances[i, j, default: .max] {
                        distances[i, j] = distI_K_J
                    }
                }
            }
        }

        self.distances = distances

        // printDistances()
    }

    func findMaxPressure() -> Int {
        var maxReleased = 0
        visit(valve: "AA", minutes: 30, open: [], released: 0, maxReleased: &maxReleased)
        return maxReleased
    }
    
    private func visit(valve: String, minutes: Int, open: Set<String>, released: Int, maxReleased: inout Int) {
        // keep track of the max pressure released so far
        maxReleased = max(maxReleased, released)

        for other in nodes where other.rate > 0 {
            // if we go to node `other` and open it, how many minutes will remain?
            let remaining = minutes - distances[valve, other.label]! - 1

            // if remaining <= 0, we can't reach it, so skip it
            // if valve is already open, skip it
            if remaining <= 0 || open.contains(other.label) {
                continue
            }

            // add in that valve's pressure for the remaining minutes
            let newReleased = released + other.rate * remaining

            // keep searching from that valve with the remaining minutes and the new pressure
            visit(valve: other.label, minutes: remaining, open: open.union([other.label]), released: newReleased, maxReleased: &maxReleased)
        }
    }
}

struct DistanceDict {
    static func key(_ from: String, _ to: String) -> String {
        "\(from)-\(to)"  
    }

    private var distances: [String: Int] = [:]

    subscript(from: String, to: String) -> Int? {
        get { distances[Self.key(from, to)] }
        set { distances[Self.key(from, to)] = newValue }
    }

    subscript(from: String, to: String, default default: Int) -> Int {
        distances[Self.key(from, to), default: `default`]
    }
}

extension Graph {
    func printDistances() {
        let labels = self.nodes.map(\.label).sorted()

        print("    " + labels.joined(separator: "  "))
        for from in labels {
            print(from, terminator: " ")
            for to in labels {
                print(distances[from, to].map { String(format: "%3d", $0) } ?? "nil", terminator: " ")
            }
            print("")
        }
    }

    var graphvizDescription: String {
        var seen = Set<String>()
        let edges = nodes.flatMap { node in
            seen.insert(node.label)
            return node.connections.compactMap {
                seen.contains($0) ? nil : "\(node.label) -- \($0)"
            }
        }.joined(separator: "\n")

        return """
        strict graph {
            overlap=scale

            \(nodes.map { node in
                let shape = node.label == "AA" ? "doublecircle" : "circle"
                return "\(node.label) [label=\"\(node.label)\\n\(node.rate)\" shape=\(shape)]"
            }.joined(separator: "\n"))

            \(edges)
        }
        """
    }
}
