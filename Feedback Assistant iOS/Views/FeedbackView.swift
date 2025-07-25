//
//  FeedbackView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var refreshing = false
    @State private var showingNewFeedbackPopover = false
    @State private var showingNewFeedbackButtonPopover = false
    @State private var showingNewFeedbackView = false
    @State private var showingProfileView = false
    @State private var draftsCount = 0
    @State private var feedbackDraft = FeedbackType(platform: "", subtitle: "")
    let feedbackHelper = FeedbackHelper()
    let table = "CommonStrings"
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? Color(UIColor.systemGray6) : Color(UIColor.systemBackground))
                .ignoresSafeArea()
            ScrollView {
                // 2 by 2 grid section
                LazyVGrid(columns: [.init(), .init()]) {
                    Group {
                        NavigationLink(destination: RecentActivityView()) {
                            GridCell(imageName: "clock.circle.fill", count: draftsCount, title: "RECENT_ACTIVITY_FILTER".localize(table: table))
                        }
                        
                        NavigationLink(destination: RequestsView()) {
                            GridCell(imageName: "exclamationmark.bubble.circle.fill", count: 0, title: "REQUESTS_FILTER".localize(table: table))
                        }
                        
                        NavigationLink(destination: AllView()) {
                            GridCell(imageName: "tray.circle.fill", count: draftsCount, title: "ALL_FILTER".localize(table: table))
                        }
                        
                        NavigationLink(destination: NewsView()) {
                            GridCell(imageName: "newspaper.circle.fill", count: 3, title: "ANNOUNCEMENTS_FILTER".localize(table: table))
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                }
                .padding()
                
                // List
                List {
                    NavigationLink(destination: InboxView()) {
                        Label("COMBINED_INBOX", systemImage: "tray")
                    }
                    
                    NavigationLink(destination: DraftsView()) {
                        HStack {
                            Label("DRAFTS_INBOX", systemImage: "doc")
                            Spacer()
                            Text(draftsCount == 0 ? "" : "\(draftsCount)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    NavigationLink(destination: SubmittedView()) {
                        Label("SUBMITTED_INBOX", systemImage: "paperplane")
                    }
                    
                    Button {
                        showingNewFeedbackPopover.toggle()
                    } label: {
                        Label("CREATE_FEEDBACK", systemImage: "bubble.and.pencil")
                    }
                    .popover(isPresented: $showingNewFeedbackPopover, attachmentAnchor: .point(.center), arrowEdge: .bottom) {
                        NavigationStack {
                            NewFeedbackView(showingNewFeedbackInfo: $showingNewFeedbackView)
                        }
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 350 : nil, height: UIDevice.current.userInterfaceIdiom == .pad ? 400 : nil)
                    }
                }
                .frame(height: 300)
                .padding(.top, -20)
                .padding(.horizontal, -5)
                .scrollDisabled(true)
                .sheet(isPresented: $showingNewFeedbackView) {
                    FeedbackDraftView(currentFeedback: $feedbackDraft)
                        .interactiveDismissDisabled()
                }
            }
            .navigationTitle("FEEDBACK".localize(table: "CommonStrings"))
            .onAppear {
                draftsCount = feedbackHelper.fetchFeedbackCount()
            }
            .refreshable {
                refreshData()
            }
            .sheet(isPresented: $showingProfileView) {
                NavigationStack {
                    SettingsView(showingSettingsSheet: $showingProfileView)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingNewFeedbackButtonPopover.toggle()
                    } label: {
                        Image(systemName: "person.fill")
                    }
                    .popover(isPresented: $showingNewFeedbackButtonPopover, attachmentAnchor: .point(.center), arrowEdge: .bottom) {
                        NavigationStack {
                            NewFeedbackView(showingNewFeedbackInfo: $showingNewFeedbackView)
                        }
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 350 : nil, height: UIDevice.current.userInterfaceIdiom == .pad ? 400 : nil)
                    }
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingNewFeedbackButtonPopover.toggle()
                    } label: {
                        Image(systemName: "bubble.and.pencil")
                    }
                    .popover(isPresented: $showingNewFeedbackButtonPopover, attachmentAnchor: .point(.center), arrowEdge: .bottom) {
                        NavigationStack {
                            NewFeedbackView(showingNewFeedbackInfo: $showingNewFeedbackView)
                        }
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 350 : nil, height: UIDevice.current.userInterfaceIdiom == .pad ? 400 : nil)
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
            draftsCount = feedbackHelper.fetchFeedbackCount()
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
