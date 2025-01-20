import XCTest
@testable import ccPositionManager

final class BalanceTests: XCTestCase {

    func testBalanceInitialization() {
        let balance = Balance(accruedInterest: 100.0)
        XCTAssertEqual(balance.accruedInterest, 100.0)
    }
}
