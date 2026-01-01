import Foundation

class AtomicArrayWrapper {
    private var internalArray: [Double] = []
    private var lock = NSLock()

    func setArray(_ newArray: [Double]) {
        lock.lock()
        defer { lock.unlock() }

        internalArray = newArray
    }

    func getArray() -> [Double] {
        lock.lock()
        defer { lock.unlock() }
        return internalArray
    }
}
