import Foundation

struct UpdateNotification: Identifiable, Equatable {
    let id: Int
    let type: NotificationType
    let title: String
    let message: String
    let timestamp: Date
    let eventId: Int?
    let eventTitle: String?
    let eventDate: String?
    let eventLocation: String?
    
    enum NotificationType {
        case registrationConfirmed
        case reminder
        case organizerUpdate
        case waitlistPromotion
        case cancellation
        case ratingRequest
        case newEvent
    }
    
    var eventDetail: UpdateEventDetail? {
        guard let eventTitle = eventTitle,
              let eventDate = eventDate,
              let eventLocation = eventLocation else {
            return nil
        }
        
        return UpdateEventDetail(
            title: eventTitle,
            date: eventDate,
            location: eventLocation
        )
    }
    
    static func == (lhs: UpdateNotification, rhs: UpdateNotification) -> Bool {
        lhs.id == rhs.id
    }
}

struct NotificationGroup: Identifiable {
    let id = UUID()
    let title: String
    let notifications: [UpdateNotification]
}

//struct UserProfileDto: Codable, Identifiable {
//    let id: Int
//    let email: String
//    let fullName: String
//    let role: String
//    let departmentId: Int?  
//}
