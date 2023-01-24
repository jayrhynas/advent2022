// adapted from https://github.com/apple/swift-algorithms/blob/main/Sources/Algorithms/Combinations.swift

extension Collection {
    func combinations(ofCount count: Int) -> [[Element]] {
        guard count > 0, count <= self.count else { return [] }

        var indexes = Array(self.indices.prefix(count))

        func advance() -> Bool {
            let i = indexes.count - 1
            self.formIndex(after: &indexes[i])
            if indexes[i] != self.endIndex { return true }

            var j = i
            while indexes[i] == self.endIndex {
                j -= 1
                guard j >= 0 else { return false }

                self.formIndex(after: &indexes[j])
                for k in indexes.indices[(j + 1)...] {
                    indexes[k] = self.index(after: indexes[k - 1])
                    if indexes[k] == self.endIndex {
                        break
                    }
                }
            }

            return true
        }

        var result: [[Element]] = []
        repeat {
            result.append(indexes.map { self[$0] })
        } while advance()
        return result
    }
}
