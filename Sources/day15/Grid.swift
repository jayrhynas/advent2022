import struct Util.Coord

protocol Entity {
    var symbol: String { get }
    var pos: Coord { get }
}

struct Grid {
    struct Sensor: Entity {
        let symbol = "S"
        let pos: Coord
        let beacon: Coord
        let dist: Int

        init(at pos: Coord, beacon: Coord) {
            self.pos = pos
            self.beacon = beacon
            self.dist = pos.manhattanDistance(to: beacon)
        }
    }

    struct Beacon: Entity, Hashable {
        let symbol = "B"
        let pos: Coord

        init(at pos: Coord) {
            self.pos = pos
        }
    }

    var sensors: [Sensor] = []
    var beacons: Set<Coord> = []

    #if DEBUG
    var entities: [Coord: Entity] = [:]
    #endif

    let bounds: (y: ClosedRange<Int>, x: ClosedRange<Int>)

    init(entities: [(sensor: Coord, beacon: Coord)]) {
        var minX = Int.max
        var maxX = Int.min
        var minY = Int.max
        var maxY = Int.min

        func updateBounds(with coord: Coord) {
            minX = min(minX, coord.x)
            maxX = max(maxX, coord.x)
            minY = min(minY, coord.y)
            maxY = max(maxY, coord.y)
        }

        for (sPos, bPos) in entities {
            updateBounds(with: sPos)
            updateBounds(with: bPos)

            let sensor = Sensor(at: sPos, beacon: bPos)

            sensors.append(sensor)
            beacons.insert(bPos)
            
            #if DEBUG
            self.entities[sPos] = sensor
            self.entities[bPos] = Beacon(at: bPos)
            #endif
        }

        self.bounds = (minY...maxY, minX...maxX)
    }

    func occupied(inRow y: Int) -> RangeSet {
        var row = RangeSet()

        for sensor in self.sensors {
            let diff = sensor.dist - abs(sensor.pos.y - y)
            guard diff >= 0 else {
                continue
            }

            row.insert((sensor.pos.x - diff)...(sensor.pos.x + diff))
        }

        return row
    }

    func countNonBeacons(y: Int) -> Int {
        let row = self.occupied(inRow: y)

        var count = row.coveredCount

        for beacon in self.beacons {
            if beacon.y == y, row.contains(beacon.x) {
                count -= 1
            }
        }
        
        return count
    }

    func findMissingBeacon(in coordRange: ClosedRange<Int>) -> Coord? {
        for y in coordRange {
            let row = self.occupied(inRow: y)

            if row.ranges.count > 1 {
                let x = row.ranges[0].upperBound + 1
                return Coord(y, x)
            }
        }

        return nil
    }
}

#if DEBUG
extension Grid.Sensor: CustomStringConvertible {
    var description: String {
        "Sensor(\(pos.x), \(pos.y)) -> Beacon(\(beacon.x), \(beacon.y)) [\(dist)]"
    }
}

extension Grid: CustomStringConvertible {
    var description: String {    
        var str = ""

        for y in bounds.y {
            for x in bounds.x {
                let entity = self.entities[Coord(y, x)]
                print(entity?.symbol ?? ".", terminator: "", to: &str)
            }
            print("", to: &str)
        }

        return str
    }
}
#endif