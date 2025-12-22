import SwiftUI

struct DummyEvents {
    static let sampleEvents: [Event] = [
        Event(
            id: 1,
            title: "iOS Development Workshop",
            description: "Learn the fundamentals of SwiftUI and build your first iOS app from scratch. This hands-on workshop will cover essential concepts including views, state management, navigation, and data flow. You'll work alongside experienced iOS developers who will guide you through building a real-world application. Perfect for beginners with basic programming knowledge who want to dive into mobile development. Bring your Mac and enthusiasm!",
            eventTypeId: 1,
            startDateTime: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            endDateTime: Calendar.current.date(byAdding: .day, value: 3, to: Date())!.addingTimeInterval(7200),
            location: "Tech Hub Conference, Room A",
            capacity: 30,
            registeredCount: 20,
            imageUrl: "https://picsum.photos/400/300?random=1",
            isActive: true,
            createdById: 101,
            createdAt: Date(),
            updatedAt: Date(),
            agenda: [
                EventAgenda(id: 1, time: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, title: "Introduction & Setup", description: "Welcome session, introductions, and Xcode environment setup"),
                EventAgenda(id: 2, time: Calendar.current.date(byAdding: .day, value: 3, to: Date())!.addingTimeInterval(2400), title: "SwiftUI Fundamentals", description: "Learn core concepts: Views, State, and basic UI components"),
                EventAgenda(id: 3, time: Calendar.current.date(byAdding: .day, value: 3, to: Date())!.addingTimeInterval(4800), title: "Build Your First App", description: "Hands-on project building a complete iOS application")
            ],
            speakers: [
                Speaker(id: 1, name: "Sarah Johnson", position: "Senior iOS Developer at Apple", image: "https://i.pravatar.cc/150?img=1"),
                Speaker(id: 2, name: "Michael Chen", position: "SwiftUI Instructor & Author", image: "https://i.pravatar.cc/150?img=13")
            ]
        ),
        Event(
            id: 2,
            title: "Community Networking Mixer",
            description: "Connect with fellow developers, designers, and tech enthusiasts over food and drinks in a relaxed, informal setting. This is your chance to expand your professional network, share ideas, and discover potential collaborators for your next big project. We'll have structured networking activities to break the ice, followed by open mingling time. Whether you're looking for job opportunities, seeking co-founders, or just want to meet like-minded people, this event is for you. Light refreshments and appetizers will be served.",
            eventTypeId: 2,
            startDateTime: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            endDateTime: Calendar.current.date(byAdding: .day, value: 7, to: Date())!.addingTimeInterval(10800),
            location: "Riverside Lounge & Bar",
            capacity: 50,
            registeredCount: 15,
            imageUrl: "https://picsum.photos/400/300?random=2",
            isActive: true,
            createdById: 102,
            createdAt: Date(),
            updatedAt: Date(),
            agenda: [
                EventAgenda(id: 4, time: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, title: "Welcome & Ice Breakers", description: "Registration, welcome drinks, and structured networking activities"),
                EventAgenda(id: 5, time: Calendar.current.date(byAdding: .day, value: 7, to: Date())!.addingTimeInterval(3600), title: "Open Networking", description: "Free mingling time with food and refreshments"),
                EventAgenda(id: 6, time: Calendar.current.date(byAdding: .day, value: 7, to: Date())!.addingTimeInterval(7200), title: "Closing & Connections", description: "Final networking round and exchange of contact information")
            ],
            speakers: []
        ),
        Event(
            id: 3,
            title: "Machine Learning Bootcamp",
            description: "Intensive 2-day bootcamp covering ML fundamentals and practical applications using Python and popular frameworks like TensorFlow and scikit-learn. Day 1 focuses on supervised learning, regression, and classification algorithms. Day 2 dives into neural networks, deep learning basics, and real-world case studies. You'll work on hands-on projects including image classification and predictive modeling. Prerequisites: Basic Python knowledge and understanding of statistics. All participants will receive course materials, datasets, and lifetime access to our online ML resource library.",
            eventTypeId: 1,
            startDateTime: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            endDateTime: Calendar.current.date(byAdding: .day, value: 15, to: Date())!,
            location: "Innovation Center, Building 3",
            capacity: 25,
            registeredCount: 18,
            imageUrl: "https://picsum.photos/400/300?random=3",
            isActive: true,
            createdById: 103,
            createdAt: Date(),
            updatedAt: Date(),
            agenda: [
                EventAgenda(id: 7, time: Calendar.current.date(byAdding: .day, value: 14, to: Date())!, title: "ML Fundamentals & Supervised Learning", description: "Introduction to machine learning, regression, and classification algorithms"),
                EventAgenda(id: 8, time: Calendar.current.date(byAdding: .day, value: 14, to: Date())!.addingTimeInterval(28800), title: "Neural Networks & Deep Learning", description: "Deep dive into neural networks, TensorFlow basics, and model training"),
                EventAgenda(id: 9, time: Calendar.current.date(byAdding: .day, value: 15, to: Date())!.addingTimeInterval(14400), title: "Real-World Projects & Deployment", description: "Hands-on projects, case studies, and model deployment strategies")
            ],
            speakers: [
                Speaker(id: 3, name: "Dr. Emily Rodriguez", position: "AI Research Scientist at Google", image: "https://i.pravatar.cc/150?img=5"),
                Speaker(id: 4, name: "James Park", position: "Machine Learning Engineer", image: "https://i.pravatar.cc/150?img=12"),
                Speaker(id: 5, name: "Lisa Wang", position: "Data Science Lead at Meta", image: "https://i.pravatar.cc/150?img=9")
            ]
        ),
        Event(
            id: 4,
            title: "Startup Pitch Night",
            description: "Watch emerging startups pitch their innovative ideas to a panel of seasoned investors and the broader community. Five carefully selected startups will present their business models, market opportunities, and growth strategies in 10-minute pitches followed by Q&A sessions. This is a fantastic opportunity to witness entrepreneurship in action, learn about new ventures in our ecosystem, and potentially discover investment opportunities. The evening will conclude with a networking reception where you can meet the founders and investors. Audience members will also vote for the People's Choice Award!",
            eventTypeId: 3,
            startDateTime: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            endDateTime: Calendar.current.date(byAdding: .day, value: 10, to: Date())!.addingTimeInterval(5400),
            location: "Downtown Entrepreneurship Hub",
            capacity: 100,
            registeredCount: 80,
            imageUrl: "https://picsum.photos/400/300?random=4",
            isActive: true,
            createdById: 104,
            createdAt: Date(),
            updatedAt: Date(),
            agenda: [
                EventAgenda(id: 10, time: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, title: "Opening & Startup Pitches", description: "Welcome remarks followed by five startup presentations (10 min each + Q&A)"),
                EventAgenda(id: 11, time: Calendar.current.date(byAdding: .day, value: 10, to: Date())!.addingTimeInterval(3600), title: "Panel Discussion & Voting", description: "Investor panel discussion and audience voting for People's Choice Award"),
                EventAgenda(id: 12, time: Calendar.current.date(byAdding: .day, value: 10, to: Date())!.addingTimeInterval(4500), title: "Networking Reception", description: "Meet the founders, investors, and fellow entrepreneurs")
            ],
            speakers: [
                Speaker(id: 6, name: "David Thompson", position: "Managing Partner at Venture Capital Fund", image: "https://i.pravatar.cc/150?img=14"),
                Speaker(id: 7, name: "Amanda Lee", position: "Angel Investor & Serial Entrepreneur", image: "https://i.pravatar.cc/150?img=10")
            ]
        ),
        Event(
            id: 5,
            title: "Hackathon 2024",
            description: "24-hour coding marathon with prizes for the best projects. Bring your creativity, coding skills, and team spirit! This year's theme is 'Tech for Social Good' - build solutions that make a positive impact on society. Whether you're interested in education, healthcare, environmental sustainability, or community development, we want to see your innovative ideas come to life. Teams of 2-5 people will compete for $10,000 in prizes across multiple categories. We'll provide meals, snacks, energy drinks, and sleeping areas for those who need a power nap. Mentors from leading tech companies will be available throughout the event to provide guidance. All skill levels welcome - beginners will be matched with experienced developers.",
            eventTypeId: 4,
            startDateTime: Calendar.current.date(byAdding: .day, value: 21, to: Date())!,
            endDateTime: Calendar.current.date(byAdding: .day, value: 22, to: Date())!,
            location: "University Campus - Engineering Building",
            capacity: 75,
            registeredCount: 70,
            imageUrl: "https://picsum.photos/400/300?random=5",
            isActive: true,
            createdById: 105,
            createdAt: Date(),
            updatedAt: Date(),
            agenda: [
                EventAgenda(id: 13, time: Calendar.current.date(byAdding: .day, value: 21, to: Date())!, title: "Kickoff & Team Formation", description: "Opening ceremony, theme reveal, team formation, and hacking begins"),
                EventAgenda(id: 14, time: Calendar.current.date(byAdding: .day, value: 21, to: Date())!.addingTimeInterval(43200), title: "Midnight Check-in & Mentorship", description: "Progress check-ins, mentor consultations, and late-night fuel"),
                EventAgenda(id: 15, time: Calendar.current.date(byAdding: .day, value: 22, to: Date())!.addingTimeInterval(7200), title: "Final Presentations & Awards", description: "Project submissions, team demos, judging, and prize ceremony")
            ],
            speakers: [
                Speaker(id: 8, name: "Robert Martinez", position: "CTO at Tech Startup", image: "https://i.pravatar.cc/150?img=15"),
                Speaker(id: 9, name: "Sophie Anderson", position: "Product Manager at Microsoft", image: "https://i.pravatar.cc/150?img=16"),
                Speaker(id: 10, name: "Kevin Patel", position: "Full Stack Developer & Mentor", image: "https://i.pravatar.cc/150?img=33")
            ]
        )
    ]
}

struct DummyCategories {
    static let sampleCategories: [Category] = [
        Category(
            id: 1,
            title: "Team Building",
            eventCount: [
                DummyEvents.sampleEvents[0],
                DummyEvents.sampleEvents[2]
            ],
            eventTypeId: [1]
        ),
        Category(
            id: 2,
            title: "Sports",
            eventCount: [
                DummyEvents.sampleEvents[1]
            ],
            eventTypeId: [2]
        ),
        Category(
            id: 3,
            title: "Workshops",
            eventCount: [
                DummyEvents.sampleEvents[0],
                DummyEvents.sampleEvents[2],
                DummyEvents.sampleEvents[4]
            ],
            eventTypeId: [3]
        ),
        Category(
            id: 4,
            title: "Happy Fridays",
            eventCount: [
                DummyEvents.sampleEvents[3]
            ],
            eventTypeId: [4]
        ),
        Category(
            id: 5,
            title: "Cultural",
            eventCount: [
                DummyEvents.sampleEvents[1],
                DummyEvents.sampleEvents[3]
            ],
            eventTypeId: [5]
        ),
        Category(
            id: 6,
            title: "Wellness",
            eventCount: [
                DummyEvents.sampleEvents[0]
            ],
            eventTypeId: [6]
        )
    ]
}

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


