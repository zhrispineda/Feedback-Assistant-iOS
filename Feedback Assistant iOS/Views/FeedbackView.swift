//
//  FeedbackView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct FeedbackView: View {
    // Variables
    @Environment(\.colorScheme) var colorScheme
    @State private var refreshing = false
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? Color(UIColor.systemGray6) : Color(UIColor.systemBackground))
                .ignoresSafeArea()
            ScrollView {
                // 2 by 2 grid section
                LazyVGrid(columns: [.init(), .init()]) {
                    Group {
                        NavigationLink(destination: RecentActivityView()) {
                            GridCell(imageName: "clock.circle.fill", count: 0, title: "RECENT_ACTIVITY_FILTER".localize(table: "CommonStrings"))
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            GridCell(imageName: "exclamationmark.bubble.circle.fill", count: 0, title: NSLocalizedString("REQUESTS_FILTER", tableName: "CommonStrings", comment: String()))
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            GridCell(imageName: "tray.circle.fill", count: 0, title: NSLocalizedString("ALL_FILTER", tableName: "CommonStrings", comment: String()))
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            GridCell(imageName: "newspaper.circle.fill", count: 0, title: NSLocalizedString("ANNOUNCEMENTS_FILTER", tableName: "CommonStrings", comment: String()))
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                }
                .padding()
                
                // List
                List {
                    NavigationLink(destination: EmptyView()) {
                        Label("COMBINED_INBOX", systemImage: "tray")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("DRAFTS_INBOX", systemImage: "doc")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("SUBMITTED_INBOX", systemImage: "paperplane")
                    }
                    
                    Button {} label: {
                        Label("CREATE_FEEDBACK", systemImage: "bubble.and.pencil")
                    }
                }
                .frame(height: 220)
                .padding(.top, -20)
                .padding(.horizontal, -5)
                .scrollDisabled(true)
            }
            .navigationTitle("FEEDBACK".localize(table: "CommonStrings"))
            .refreshable {
                refreshData()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    ZStack {
                        HStack {
                            Spacer()
                            Button {} label: {
                                Image(systemName: "bubble.and.pencil")
                            }
                        }
                        if refreshing {
                            HStack {
                                ProgressView()
                                Text("LOADING_ELLIPSES")
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Functions
    private func refreshData() {
        Task {
            withAnimation {
                refreshing = true
            }
            try? await Task.sleep(for: .seconds(Int.random(in: 1...2)))
            withAnimation {
                refreshing = false
            }
        }
    }
}

struct GridCell: View {
    var imageName = String()
    var count = Int()
    var title = String()
    
    var body: some View {
        GroupBox {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Image(systemName: imageName)
                        .padding([.leading, .top], -5)
                        .font(.title)
                        .foregroundStyle(.white, .purple)
                    Spacer()
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                Spacer()
                Text("\(count)")
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding([.trailing, .top], -5)
            }
        }
        .groupBoxStyle(CustomGroupBoxStyle())
    }
}

struct CustomGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
    }
}

struct CustomButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundStyle(configuration.isPressed ? Color.white : Color.primary)
            .background(configuration.isPressed ? Color.purple : Color(colorScheme == .light ? Color.white : Color(UIColor.systemGray6)))
            .cornerRadius(8)
    }
}

#Preview {
    NavigationStack {
        FeedbackView()
    }
}
