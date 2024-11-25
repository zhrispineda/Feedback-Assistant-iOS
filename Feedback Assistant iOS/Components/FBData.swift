//
//  FBData.swift
//  Feedback Assistant iOS
//

import Foundation

class FBData {
    func saveFeedbackDraft(_ feedback: FeedbackType) {
        var feedbacks = fetchFeedbacks()
        feedbacks.append(feedback)
        saveFeedbacks(feedbacks)
    }

    func fetchFeedbacks() -> [FeedbackType] {
        if let storedFeedbacks = UserDefaults.standard.codable(forKey: "feedbacks") as [FeedbackType]? {
            return storedFeedbacks
        }
        return []
    }

    func saveFeedbacks(_ feedbacks: [FeedbackType]) {
        UserDefaults.standard.setCodable(feedbacks, forKey: "feedbacks")
    }

    func sortedFeedbacks() -> [FeedbackType] {
        return fetchFeedbacks().sorted { $0.timestamp > $1.timestamp }
    }
    
    func updateFeedback(_ updatedFeedback: FeedbackType) {
        var feedbacks = fetchFeedbacks()
        
        if let index = feedbacks.firstIndex(where: { $0.id == updatedFeedback.id }) {
            feedbacks[index] = updatedFeedback
            saveFeedbacks(feedbacks)
        }
    }
    
    func deleteFeedback(at offsets: IndexSet) {
        var feedbacks = sortedFeedbacks()
        feedbacks.remove(atOffsets: offsets)
        saveFeedbacks(feedbacks)
    }
    
    func fetchFeedbackCount() -> Int {
        if let storedFeedbacks = UserDefaults.standard.codable(forKey: "feedbacks") as [FeedbackType]? {
            return storedFeedbacks.count
        }
        return 0
    }
}

struct FeedbackType: Codable, Identifiable {
    var id = UUID()
    var platform: String
    var title: String
    var subtitle: String
    var description: String
    var timestamp: Date
    var status: Status
    var productArea: ProductArea
    
    var timestampText: String {
        let formatter = DateFormatter()
        let calendar = Calendar.current

        if calendar.isDateInToday(timestamp) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: timestamp)
        }
        
        if calendar.isDateInYesterday(timestamp) {
            return "Yesterday"
        }

        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: timestamp)
    }
    
    init(platform: String, title: String = "Untitled Feedback", subtitle: String, description: String = "No answer provided", timestamp: Date = Date(), status: Status = .draft, productArea: ProductArea = .other) {
        self.platform = platform
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.timestamp = timestamp
        self.status = status
        self.productArea = productArea
    }
}

enum Status: Decodable, Encodable {
    case draft, open, attention
}

enum ProductArea: Decodable, Encodable {
    case thirdParty, appStore, appSwitcher, audio, calculator, calendar, camera, clock, controlCenter, displayGraphics, feedbackAssistant, homeScreen, installationSetupMigrationRecovery, mail, maps, menuBar, music, news, passwords, photos, safari, settings, stageManager, swiftUI, systemCrashes, systemSettings, tvAppAppleTvPlus, translateApp, watchApp, weather, xcode, other
}
