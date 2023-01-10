import Foundation

enum Item {
    case val(Int)
    indirect case list([Item])
}

func compare(_ lhs: Int, _ rhs: Int) -> ComparisonResult {
    return lhs < rhs ? .orderedAscending
         : lhs > rhs ? .orderedDescending
         :             .orderedSame
}

func compare(_ lhs: [Item], _ rhs: [Item]) -> ComparisonResult {
    for (lhs, rhs) in zip(lhs, rhs) {
        let result = compare(lhs, rhs)
        
        if result == .orderedSame {
            continue
        }

        return result
    }

    return compare(lhs.count, rhs.count)
}

func compare(_ lhs: Item, _ rhs: Item) -> ComparisonResult {
    switch (lhs, rhs) {
    case let (.val(lhs), .val(rhs)):
        return compare(lhs, rhs)

    case let (.val(lhs), .list):
        return compare(.list([.val(lhs)]), rhs)

    case let (.list, .val(rhs)):
        return compare(lhs, .list([.val(rhs)]))

    case let (.list(lhs), .list(rhs)):
        return compare(lhs, rhs)
    }
}
