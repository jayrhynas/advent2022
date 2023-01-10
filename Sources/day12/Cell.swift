class Cell: CustomStringConvertible {
    private static let ascii_a = Character("a").asciiValue!

    let height: UInt8
    let pos: Coord

    enum Special {
        case start, end
    }

    let special: Special?
    
    var previous: (Cell, Direction)? = nil
    var dist: Int? = nil

    init(_ letter: Character, pos: Coord) {
        self.pos = pos
        
        if letter == "S" {
            height = 0
            special = .start
            dist = 0
        } else if letter == "E" {
            height = 25
            special = .end
            dist = nil
        } else {
            height = letter.asciiValue! - Self.ascii_a
            special = nil
            dist = nil
        }
        previous = nil
    }

    var description: String {
        switch special {
        case .start: return "S"
        case .end:   return "E"
        default:     return "\(Unicode.Scalar(height + Self.ascii_a))"
        }
    }
}
