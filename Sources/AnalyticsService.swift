import Foundation

class AnalyticsService {
    static let shared = AnalyticsService()

    func trackPageView(title: String) {
        print("[Analytics] Page View: \(title)")
    }
}