class CPU {
    static var trace = false

    var x = 1

    private let recordingInterval: Int
    private var nextRecording: Int

    private(set) var signalStrengths: [Int] = []

    private var cycle = 0

    init(startRecordingAt start: Int = 20, recordingInterval: Int = 40) {
        self.recordingInterval = recordingInterval
        self.nextRecording = start
    }

    func run(_ instructions: [Instruction]) {
        for instruction in instructions {
            switch instruction {
            case .noop:
                cycle += 1
                record()

            case .addx(let v):
                cycle += 2
                record()
                x += v
            }
        }
    }

    private func record() {
        trace("[\(cycle)] X=\(x)")

        if cycle >= nextRecording {
            signalStrengths.append(x * nextRecording)
            nextRecording += recordingInterval
        }
    }

    private func trace(_ str: String) {
        guard Self.trace else { return }

        print(str)
    }
}