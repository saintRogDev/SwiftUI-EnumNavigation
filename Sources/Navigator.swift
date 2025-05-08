import Foundation

class Navigator: ObservableObject {
    @Published var paths: [Path] = []

    enum Path: Hashable {
        case signUp
        case events
        case eventDetails(Event)
        case seatingSelection

        var page: PageViewProtocol {
            switch self {
            case .signUp:
                return SignUpPage(viewModel: SignUpViewModel())
            case .events:
                return EventsPage(viewModel: EventsViewModel())
            case .eventDetails(let event):
                return EventDetailsPage(viewModel: EventDetailsViewModel(event: event))
            case .seatingSelection:
                return SeatingPage(viewModel: SeatingViewModel())
            }
        }
    }

    var currentPage: PageViewProtocol {
        paths.last?.page ?? Path.events.page
    }
}