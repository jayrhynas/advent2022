struct Rucksack {
    let compartment1: Set<Character>
    let compartment2: Set<Character>

    init(_ items: [Character]) {
        let midpoint = items.count / 2
        self.compartment1 = Set(items[0..<midpoint])
        self.compartment2 = Set(items[midpoint..<items.count])
    }

    private static let a = Character("a").asciiValue!
    private static let A = Character("A").asciiValue!

    static func priority(of character: Character) -> Int {
        let val = character.asciiValue!
        if val >= self.a {
            return Int(val - self.a + 1)
        } else {
            return Int(val - self.A + 27)
        }
    }
}

extension Rucksack: CustomStringConvertible {
    var description: String {
        let c1 = compartment1.reduce("") { $0 + String($1) }
        let c2 = compartment2.reduce("") { $0 + String($1) }
        return "\(c1)|\(c2)"
    }
}