import XCTest
@testable import FullscreenPopup

final class FullscreenPopupTests: XCTestCase {
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    func testDurationToNanoseconds() throws {
        let duration: Duration = .seconds(0.35)
        XCTAssertEqual(duration.nanoseconds, 350_000_000)
    }
}
