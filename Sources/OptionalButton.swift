import SwiftUI

struct OptionalButton: View {
    let cta: PageViewProtocol.Cta?

    var body: some View {
        if let cta = cta {
            Button(cta.title, action: cta.action)
        }
    }
}