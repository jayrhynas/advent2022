struct Filesystem {
    final class Node {
        enum NodeType  {
            case dir, file
        }

        let type: NodeType
        let name: String

        let parent: Node?
        fileprivate(set) var children: [Node] {
            didSet {
                _size = nil
            }
        }

        private var _size: Int?

        var size: Int {
            if let size = _size {
                return size
            }

            switch self.type {
            case .dir:
                let size = children.reduce(0) { $0 + $1.size }
                _size = size
                return size
            case .file:
                fatalError()
            }
        }

        private init(type: NodeType, name: String, parent: Node?, children: [Node], size: Int?) {
            self.type = type
            self.name = name
            self.parent = parent
            self.children = children
            self._size = size
        }

        static func root(children: [Node] = []) -> Node {
            self.init(type: .dir, name: "/", parent: nil, children: children, size: nil)
        }

        static func dir(name: String, parent: Node, children: [Node] = []) -> Node {
            self.init(type: .dir, name: name, parent: parent, children: children, size: nil)
        }

        static func file(name: String, parent: Node, size: Int) -> Node {
            self.init(type: .file, name: name, parent: parent, children: [], size: size)
        }
    }

    let root: Node

    init(from commands: [Command]) {
        var commands = commands[...]

        guard case .cd(.root) = commands.popFirst() else {
            fatalError()
        }

        let root = Node.root()
        var cur = root

        while let command = commands.popFirst() {
            switch command {
            case .cd(.root):
                cur = root
            case .cd(.up):
                cur = cur.parent!
            case .cd(.down(let dirName)):
                cur = cur.children.first { $0.name == dirName }!

            case .ls(let listings):
                cur.children = listings.map {
                    switch $0 {
                    case let .dir(name):        return .dir(name: name, parent: cur)
                    case let .file(size, name): return .file(name: name, parent: cur, size: size)
                    }
                }
            }
        }
        self.root = root
    }
}

extension Filesystem.Node {
    func findDirs(maxFilesize: Int) -> [Filesystem.Node] {
        var found: [Filesystem.Node] = []

        for child in self.children where child.type == .dir {
            if child.size <= maxFilesize {
                found.append(child)
            }
            found.append(contentsOf: child.findDirs(maxFilesize: maxFilesize))
        }

        return found
    }
}

extension Filesystem: CustomStringConvertible {
    var description: String {
        root.description
    }
}

extension Filesystem.Node: CustomStringConvertible {
    var description: String {
        self.description(showDirSize: false)
    }

    func description(showDirSize: Bool) -> String {
        var desc = ""
        print(showDirSize: showDirSize, to: &desc)
        return desc
    }

    private func print(level: Int = 0, showDirSize: Bool, to str: inout String) {
        let indent = String(repeating: "  ", count: level)
        switch self.type {
        case .dir:
            Swift.print("\(indent)- \(name) (dir\(showDirSize ? ", size=\(size)" : ""))", to: &str)
            for child in children {
                child.print(level: level + 1, showDirSize: showDirSize, to: &str)
            }

        case .file:
            Swift.print("\(indent)- \(name) (file, size=\(size))", to: &str)
        }
    }
}
