class CPU {
    static var trace = false

    let instructions: [Instruction]
    private(set) var x = 1

    let crtSize: (width: Int, height: Int)?

    private let recordingInterval: Int?
    private var nextRecording: Int
    private(set) var signalStrengths: [Int] = []

    private var cycle = 0

    init(instructions: [Instruction], crt: (width: Int, height: Int)? = (40, 6), recording: (start: Int, interval: Int)? = (20, 40)) {
        self.instructions = instructions
        self.crtSize = crt

        self.recordingInterval = recording?.interval
        self.nextRecording = recording?.start ?? 0
    }

    func run() {
        for instruction in instructions {
            switch instruction {
            case .noop:
                tickCRT()
                cycle += 1
                record()

            case .addx(let v):
                tickCRT()
                cycle += 1
                tickCRT()
                cycle += 1
                record()
                x += v
            }
        }
    }

    private func tickCRT() {
        guard let crtSize else { return }

        let xPos = cycle % crtSize.width
        if ((x - 1)...(x + 1)).contains(xPos) {
            print("#", terminator: "")
        } else {
            print(".", terminator: "")
        }

        if xPos == crtSize.width - 1 {
            print("")
        }
    }

    private func record() {
        trace("[\(cycle)] X=\(x)")

        if let interval = recordingInterval, cycle >= nextRecording {
            signalStrengths.append(x * nextRecording)
            nextRecording += interval
        }
    }

    private func trace(_ str: String) {
        guard Self.trace else { return }

        print(str)
    }
}