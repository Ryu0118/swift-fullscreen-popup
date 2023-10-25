import Foundation

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration {
    var nanoseconds: UInt64 {
        UInt64((Double(components.seconds) + Double(components.attoseconds) / 1e18) * 1_000_000_000)
    }
}
