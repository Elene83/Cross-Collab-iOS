import SwiftUI

struct DummyFAQs {
    static let sampleFAQs: [FAQ] = [
        FAQ(
            id: 1,
            question: "How do I register for an event?",
            answer: "Simply browse our events, select the one you're interested in, and click the 'Register' button. You'll need to be logged in to complete your registration."
        ),
        FAQ(
            id: 2,
            question: "Can I cancel my registration?",
            answer: "Yes, you can cancel your registration up to 24 hours before the event starts. Go to 'My Events' and select 'Cancel Registration'."
        ),
        FAQ(
            id: 3,
            question: "Are events free to attend?",
            answer: "Most of our events are free for members. Some special workshops or conferences may require a small fee, which will be clearly indicated on the event page."
        ),
        FAQ(
            id: 4,
            question: "What happens if an event is full?",
            answer: "You can join the waitlist, and we'll notify you if a spot opens up. We also regularly add new events, so check back often!"
        ),
        FAQ(
            id: 5,
            question: "How do I become an event organizer?",
            answer: "If you're interested in hosting events, please contact our team through the 'Contact Us' page. We welcome community members who want to share their expertise!"
        )
    ]
}


