import SwiftUI

struct PageView: View {
    let page: PageViewProtocol

    var body: some View {
        VStack {
            page.content
            Spacer()
            OptionalButton(cta: page.primaryCta)
        }
        .padding()
        .navigationTitle(page.title)
        .onAppear {
            AnalyticsService.shared.trackPageView(title: page.title)
        }
    }
}