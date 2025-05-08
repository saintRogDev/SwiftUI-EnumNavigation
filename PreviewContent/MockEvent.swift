struct Event {
    let id: String
    let name: String
    let description: String
}

class EventStore {
    static let shared = EventStore()
    func event(withID id: String) -> Event? {
        return Event(id: id, name: "Mock Event", description: "This is a mock event.")
    }
}