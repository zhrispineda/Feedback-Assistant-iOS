//
//  NewsView.swift
//  Feedback Assistant iOS
//
//  Feedback Assistant > News
//

import SwiftUI

struct NewsView: View {
    // Variables
    @State private var searchText = String()
    @State private var feedbacks: [FeedbackType] = []
    @State private var filterEnabled = false
    let table = "CommonStrings"
    let dateFormatter = DateFormatter()
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
                    FeedbackNewsView(html: feedback.description, title: feedback.title)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(feedback.status == .attention ? .accent : .clear)
                                    .font(.caption2)
                                Text(feedback.title.isEmpty ? "Untitled Feedback" : feedback.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                Spacer()
                                Text(feedback.timestampText)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Text("News – \(feedback.platform)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(.leading, 15)
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
        .onAppear {
            dateFormatter.dateFormat = "yyyy-M-d'T'HH:mm:ssZ"
            
            feedbacks = [
                FeedbackType(platform: "Apple Beta Software Program", title: "Apple Beta Software Program", subtitle: "", description: "3421", timestamp: dateFormatter.date(from: "2019-06-05T01:12:41Z") ?? Date(), status: .attention, productArea: .announcement),
                FeedbackType(platform: "Developer Seed", title: "Apple Developer Program", subtitle: "", description: "3416", timestamp: dateFormatter.date(from: "2019-06-03T19:21:22Z") ?? Date(), status: .attention, productArea: .announcement)
            ]
        }
        .navigationTitle("ANNOUNCEMENTS_FILTER".localize(table: table))
        .searchable(text: $searchText, placement: .navigationBarDrawer)
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
                        NewFeedbackButton()
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
        NewsView()
    }
}
