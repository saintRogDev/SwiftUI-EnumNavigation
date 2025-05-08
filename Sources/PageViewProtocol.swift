import SwiftUI

protocol PageViewProtocol {
    typealias Content = AnyView
    typealias Cta = (title: String, action: () -> Void)

    var title: String { get }
    var content: Content { get }
    var primaryCta: Cta? { get }
    var secondaryCta: Cta? { get }
}