// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: Person Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        guard lhs.age == rhs.age else { return false }
        guard lhs.name == rhs.name else { return false }
        return true
    }
}
