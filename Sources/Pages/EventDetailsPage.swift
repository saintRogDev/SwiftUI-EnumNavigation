import SwiftUI

struct EventDetailsPage: PageViewProtocol {
    let viewModel: EventDetailsViewModel

    var title: String { viewModel.event.name }

    var content: Content {
        AnyView(Text(viewModel.event.description))
    }

    var primaryCta: Cta? {
        ("RSVP", { viewModel.rsvp() })
    }

    var secondaryCta: Cta? { nil }
}