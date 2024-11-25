//
//  RecentActivityView.swift
//  Feedback Assistant iOS
//
//  Feedback Assistant > Recent Activity
//

import SwiftUI

struct RecentActivityView: View {
    // Variables
    @State private var searchText = String()
    @State private var filterEnabled = false
    @State private var feedbacks: [FeedbackType] = []
    let table = "CommonStrings"
    let fbData = FBData()
    var filteredFeedbacks: [FeedbackType] {
        if searchText.isEmpty {
            return feedbacks
        } else {
            return feedbacks.filter { feedback in
                feedback.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredFeedbacks) { feedback in
                NavigationLink {
                    FeedbackReadDraftView(feedback: feedback)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(feedback.title)
                                    .font(.headline)
                                Spacer()
                                Text(feedback.timestampText)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Text("Feedback Draft – \(feedback.platform)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle("RECENT_ACTIVITY_FILTER".localize(table: table))
        .searchable(text: $searchText, placement: .navigationBarDrawer)
        .onAppear {
            feedbacks = fbData.sortedFeedbacks()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                ZStack {
                    HStack {
                        Button {
                            withAnimation {
                                filterEnabled.toggle()
                            }
                        } label: {
                            Image(systemName: filterEnabled ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .imageScale(.large)
                        }
                        Spacer()
                        Button {} label: {
                            Image(systemName: "bubble.and.pencil")
                                .imageScale(.large)
                        }
                    }
                    if filterEnabled {
                        VStack(spacing: -5) {
                            Text("FILTERED_BY_PROMPT", tableName: table)
                                .font(.subheadline)
                            Button("FILTER_OPEN".localize(table: table)) {}
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecentActivityView()
    }
}
