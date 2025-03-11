//
//  OnBoardingDetailView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct OnBoardingDetailView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var frameY = Double()
    @State private var opacity = Double()
    var table = "PrivacyPane"
    let tables = [ // SPLASH_SHORT_TITLE tables
        "Activity",
        "ADPAnalytics",
        "AirDrop",
        "AppStore",
        "OBAppleID", // AppleID
        "Advertising",
        "AppleArcade",
        "AppleBooks",
        "AppleCard",
        "ApplePayCash",
        "FitnessPlus",
        "Intelligence",
        "Maps",
        "BusinessChat",
        "AppleMusic",
        "AppleMusicFriends",
        "News",
        "NewsletterIssues",
        "ApplePay",
        "ApplePayLater",
        "Podcasts",
        "ResearchApp",
        "TVApp",
        "Camera",
        "CheckIn",
        "ClassKit",
        "ConnectedCards",
        "EmergencySOS",
        "ExposureNotifications",
        "FaceID",
        "FaceTime",
        "FamilySetup",
        "FamilySharing",
        "FindMy",
        "GameCenter",
        "GymKit",
        "HealthApp",
        "HealthRecords",
        "HomeElectricity",
        "AnalyticsiCloud",
        "iCloudKeychain",
        "PrivateRelay",
        "Identity",
        "ImproveApplePay",
        "ImproveAstVoice",
        "ImproveCommunicationSafety",
        "ImproveEVRouting",
        "ImproveFitnessPlus",
        "ImproveHandwashing",
        "ImproveHealth",
        "ImproveHealthRecords",
        "ImproveMaps",
        "ImproveSafetyFeatures",
        "ImproveSensitiveContentWarning",
        "ImproveSiriDictation",
        "WheelchairMode",
        "iTunesStore",
        "Journal",
        "LocationServices",
        "MailPrivacyProtection",
        "MapsRAP",
        "OBMessages", // Messages
        "MySports",
        "NFCAndSEPlatform",
        "Passwords",
        "SpatialAudioProfiles",
        "OBPhotos", // Photos
        "RatingsAndPhotos",
        "Safari",
        "SafetyFeatures",
        "Savings",
        "SiriSuggestions",
        "SensorUsage",
        "ShortcutsSharing",
        "SignInWithApple",
        "SignInWithAppleAtWorkAndSchool",
        "AskSiri",
        "SMSFiltering",
        "Stocks",
        "OBTouchID", // TouchID
        "Translate",
        "TVProvider",
        "VPNs",
        "Wallet",
        "Weather",
        "CloudCalling"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    Image(_internalSystemName: "privacy.handshake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .foregroundStyle(Color.accent)
                        .overlay { // For calculating opacity of the principal toolbar item
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .scrollView).minY) {
                                        frameY = geo.frame(in: .scrollView).minY
                                    }
                            }
                        }
                    Text("SPLASH_TITLE", tableName: table)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("SPLASH_SUMMARY", tableName: table)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Text(UIDevice.current.userInterfaceIdiom == .phone ? "FOOTER_TEXT_IPHONE" : "FOOTER_TEXT_IPAD", tableName: table)
                        .font(.subheadline)
                    Text("[\("BUTTON_TITLE".localize(table: "OBAppleID"))](apple.com/privacy)", tableName: "OBAppleID")
                        .padding(.bottom, 10)
                        .font(.subheadline)
                        
                }
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Section {
                    ForEach(tables, id: \.self) { item in
                        NavigationLink(destination: OnBoardingView(table: item, childView: true)) {
                            Text(splashTitle(textTable: item))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor.label))
                        }
                        .listRowBackground(Color(UIColor.tertiarySystemGroupedBackground))
                    }
                }
            }
            .navigationTitle("PRIVACY".localize(table: "PSSystemPolicy"))
            .navigationBarTitleDisplayMode(.inline)
            .background(colorScheme == .light ? .white : Color(UIColor.secondarySystemBackground))
            .scrollContentBackground(.hidden)
            .contentMargins(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 90 : 40, for: .scrollContent)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SPLASH_TITLE", tableName: table)
                        .opacity(frameY < -10 ? 1 : 0)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
        }
    }
    
    private func splashTitle(textTable: String) -> String {
        if NSLocalizedString("SPLASH_SHORT_TITLE_WIFI", tableName: textTable, comment: "") != "SPLASH_SHORT_TITLE_WIFI" {
            return NSLocalizedString("SPLASH_SHORT_TITLE_WIFI", tableName: textTable, comment: "")
        }
        return NSLocalizedString("SPLASH_SHORT_TITLE", tableName: textTable, comment: "")
    }
}

#Preview {
    OnBoardingDetailView()
}
