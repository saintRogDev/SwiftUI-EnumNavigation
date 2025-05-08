# SwiftUI Enum Based Navigation Architecture

A type safe, testable, and modular navigation system for SwiftUI using enum based routing and protocol driven screen composition.

---

## 📌 Why This Exists

SwiftUI’s built in navigation tools are powerful, but they can become difficult to scale, test, or coordinate in apps with dynamic routing, multiple entry points, or feature flags.

This architecture introduces:

* Centralized, strongly typed navigation
* Declarative page rendering via protocols
* Support for deep linking, analytics, and previews

 --

## 🏗 Architecture Summary

### Components:

* `Navigator`: Owns a `@Published` path stack of typed routes
* `Navigator.Path`: Enum representing all navigable destinations, with associated values
* `PageViewProtocol`: A protocol for declaring screen structure (title, content, CTAs)
* `PageView`: Renders any conforming page consistently
* `OptionalButton`: A helper for cleanly rendering optional CTAs
* `DeepLinkParser`: Converts incoming URLs to navigation paths
* `AnalyticsService`: Hooks into page lifecycle for tracking

---

## 🧩 Example

```swift
enum Path: Hashable {
    case signUp
    case eventDetails(Event)

    var page: PageViewProtocol {
        switch self {
        case .signUp:
            return SignUpPage(viewModel: SignUpViewModel())
        case .eventDetails(let event):
            return EventDetailsPage(viewModel: EventDetailsViewModel(event: event))
        }
    }
}

class Navigator: ObservableObject {
    @Published var paths: [Path] = []
    var currentPage: PageViewProtocol { paths.last?.page ?? Path.signUp.page }
}
```

---

## 🧭 Usage

### In Your ContentView

```swift
NavigationStack(path: $navigator.paths) {
    PageView(page: navigator.currentPage)
        .navigationDestination(for: Navigator.Path.self) { path in
            PageView(page: path.page)
        }
        .onOpenURL { url in
            if let path = DeepLinkParser.parse(url: url) {
                navigator.paths.append(path)
            }
        }
}
```

---

## 🔗 Deep Linking

```swift
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
```

---

## 📊 Analytics

```swift
class AnalyticsService {
    static let shared = AnalyticsService()
    func trackPageView(title: String) {
        print("[Analytics] Page View: \(title)")
    }
}
```

Used in `PageView.onAppear { ... }`

---

## ✅ Benefits

* ✅ Strongly typed navigation (no route strings)
* ✅ Reusable, testable, protocol based page definitions
* ✅ Analytics and deep linking support built in
* ✅ Great for previews and UI tests

---

## 🧪 Testing

```swift
func testEventDetailsPageGeneration() {
    let event = Event(id: "123", name: "Sample")
    let path = Navigator.Path.eventDetails(event)
    let page = path.page

    XCTAssertEqual(page.title, "Sample")
}
```

---

## 🧰 Future Work

* Page factories
* Tab bar integration
* Middleware (auth gate, onboarding gate)

---

## 📂 Folder Structure (Suggested)

```
SwiftUI-EnumNavigation/
├── Sources/
│   ├── Navigator.swift
│   ├── PageViewProtocol.swift
│   ├── PageView.swift
│   ├── OptionalButton.swift
│   └── Pages/
│       ├── EventDetailsPage.swift
│       └── SignUpPage.swift
├── Tests/
│   └── NavigationTests.swift
├── PreviewContent/
│   └── MockEvent.swift
├── ExampleApp/
└── README.md
```

---

## License

MIT

---

## 🙌 Contributions Welcome

This is a modular, open architecture — feel free to fork, extend, and share improvements.

> Built with ❤️ for scalable SwiftUI apps.
