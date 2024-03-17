import XCTest
@testable import SwiftWGSRPD

final class SwiftWGSRPDTests: XCTestCase {
    func testDecoding() throws {
        let wdsrpd = WGSRPD.default
        // Ensure the WGSRPD has the correct amount of decoded items
        XCTAssertEqual(wdsrpd.items.count, 369)
    }
}
