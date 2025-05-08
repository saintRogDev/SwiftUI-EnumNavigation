import XCTest

final class NavigationTests: XCTestCase {
    func testEventDetailsPageGeneration() {
        let event = Event(id: "123", name: "Sample", description: "Test")
        let path = Navigator.Path.eventDetails(event)
        let page = path.page

        XCTAssertEqual(page.title, "Sample")
    }
}