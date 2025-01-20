import XCTest
@testable import ccPositionManager

final class PositionTests: XCTestCase {

    func testPositionInitialization() {
        let position = Position(symbol: "AAPL", averagePrice: 150.0)
        XCTAssertEqual(position.symbol(), "AAPL")
        XCTAssertEqual(position.m_averagePrice, 150.0)
    }
}
