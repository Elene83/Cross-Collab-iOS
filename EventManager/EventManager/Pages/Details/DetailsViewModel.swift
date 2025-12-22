import SwiftUI

extension DetailsView {
    class ViewModel: Observable {
        var events = DummyEvents.sampleEvents
        var categories: [Category] = DummyCategories.sampleCategories
        var faqs: [FAQ] = DummyFAQs.sampleFAQs
    }
}
