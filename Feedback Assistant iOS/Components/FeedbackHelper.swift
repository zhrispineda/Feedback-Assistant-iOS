//
//  FeedbackHelper.swift
//  Feedback Assistant iOS
//

import Foundation

class FeedbackHelper {
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
    
    func deleteFeedbackById(withId id: UUID) {
        var feedbacks = sortedFeedbacks()
        feedbacks.removeAll { $0.id == id }
        saveFeedbacks(feedbacks)
    }
    
    func fetchFeedbackCount() -> Int {
        if let storedFeedbacks = UserDefaults.standard.codable(forKey: "feedbacks") as [FeedbackType]? {
            return storedFeedbacks.count
        }
        return 0
    }
    
    let feedbackTypes: [FeedbackType] = [
        FeedbackType(platform: "iOS & iPadOS", subtitle: "iOS & iPadOS features, apps, and devices"),
        FeedbackType(platform: "macOS", subtitle: "macOS features, apps, and devices"),
        FeedbackType(platform: "tvOS", subtitle: "tvOS features, apps, and devices"),
        FeedbackType(platform: "visionOS", subtitle: "visionOS features, apps, and devices"),
        FeedbackType(platform: "watchOS", subtitle: "watchOS features, apps, and devices"),
        FeedbackType(platform: "HomePod", subtitle: "HomePod features, apps, and devices"),
        FeedbackType(platform: "AirPods Beta Firmware", subtitle: "AirPods Beta Firmware features, and devices"),
        FeedbackType(platform: "Developer Technologies & SDKs", subtitle: "APIs and Frameworks for all Apple Platforms"),
        FeedbackType(platform: "Enterprise & Education", subtitle: "MDM, enterprise and education programs and apps, training and certification"),
        FeedbackType(platform: "MFi Technologies", subtitle: "MFi Certification and tools")
    ]
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
    var productType: String
    
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
    
    init(platform: String, title: String = "", subtitle: String, description: String = "", timestamp: Date = Date(), status: Status = .draft, productArea: ProductArea = .none, productType: String = "") {
        self.platform = platform
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.timestamp = timestamp
        self.status = status
        self.productArea = productArea
        self.productType = productType
    }
}

enum Status: Decodable, Encodable {
    case draft, open, attention, closed
}

enum ProductArea: String, CaseIterable, Decodable, Encodable {
    case announcement = "Announcement"
    case thirdParty = "3rd Party Apps"
    case accessibility = "Accessibility"
    case airDrop = "AirDrop"
    case airPlay = "AirPlay"
    case airPods = "AirPods"
    case appPrivacyReport = "App Privacy Report"
    case appStore = "App Store"
    case appSwitcher = "App Switcher"
    case appleIntelligence = "Apple Intelligence"
    case applePay = "Apple Pay"
    case audio = "Audio"
    case autoUnlock = "Auto Unlock"
    case backup = "Backup"
    case batteryCharging = "Battery Charging"
    case batteryLife = "Battery Life"
    case bluetooth = "Bluetooth"
    case books = "Books"
    case calculator = "Calculator"
    case calendar = "Calendar"
    case camera = "Camera"
    case carKey = "Car Keys"
    case carPlay = "CarPlay"
    case cellularService = "Cellular Service (Calls & Data)"
    case clock = "Clock"
    case contacts = "Contacts"
    case continuity = "Continuity/Handoff"
    case controlCenter = "Control Center"
    case deviceWarm = "Device Feels Warm"
    case deviceSyncing = "Device Syncing"
    case faceId = "Face ID"
    case faceTime = "FaceTime"
    case faceTimeSharePlay = "FaceTime - SharePlay"
    case feedbackAssistant = "Feedback Assistant"
    case files = "Files app"
    case findMy = "Find My"
    case fitness = "Fitness/Fitness+"
    case focus = "Focus"
    case freeform = "Freeform"
    case gameController = "Game Controller"
    case haptics = "Haptics/Vibration"
    case health = "Health"
    case homeApp = "Home App & HomeKit / Matter Accessories"
    case homeScreen = "Home Screen"
    case iCloud = "iCloud"
    case imagePlayground = "Image Playground"
    case iTunes = "iTunes Store"
    case journal = "Journal"
    case keyboard = "Keyboard"
    case lockScreen = "Lock Screen"
    case mail = "Mail"
    case maps = "Maps"
    case messages = "Messages"
    case music = "Music"
    case musicClassical = "Music Classical"
    case news = "News"
    case notes = "Notes"
    case notificationCenter = "Notification Center"
    case notifications = "Notifications"
    case passwords = "Passwords"
    case phone = "Phone app"
    case photos = "Photos"
    case pictureInPicture = "Picture in Picture"
    case podcasts = "Podcasts"
    case printing = "Printing"
    case reminders = "Reminders"
    case rotation = "Rotation"
    case safari = "Safari"
    case safetyCheck = "Safety Check"
    case screenRecording = "Screen Recording"
    case screenTime = "Screen Time"
    case scribble = "Scribble"
    case security = "Security"
    case settings = "Settings"
    case shareSheet = "Share Sheet"
    case shortcuts = "Shortcuts"
    case sidecar = "Sidecar"
    case siri = "Siri"
    case sleep = "Sleep"
    case softwareUpdate = "Software Update"
    case splitView = "Split View/Drag and Drop"
    case spotlightSearch = "Spotlight Search"
    case stageManager = "Stage Manager"
    case standBy = "StandBy"
    case systemCrashes = "System Crashes"
    case systemSlow = "System Slow/Unresponsive"
    case touchId = "Touch ID"
    case translateApps = "Translate app"
    case tvApp = "TV app/Apple TV+"
    case vpn = "VPN"
    case wallet = "Wallet"
    case wallpaper = "Wallpaper"
    case watchApp = "Watch app"
    case weather = "Weather"
    case wifi = "Wi-Fi"
    case other = "Something else not on this list"
    
    case none = "None"
}
