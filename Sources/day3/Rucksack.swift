struct Rucksack {
    let compartment1: Set<Character>
    let compartment2: Set<Character>

    init(_ items: [Character]) {
        let midpoint = items.count / 2
        self.compartment1 = Set(items[0..<midpoint])
        self.compartment2 = Set(items[midpoint..<items.count])
    }
}