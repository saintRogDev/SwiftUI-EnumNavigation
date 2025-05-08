import Foundation

struct DeepLinkParser {
    static func parse(url: URL) -> Navigator.Path? {
        switch url.pathComponents {
        case ["/events", let id]:
            if let event = EventStore.shared.event(withID: id) {
                return .eventDetails(event)
            }
        case ["/signup"]:
            return .signUp
        default:
            return nil
        }
    }
}