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
    @State private var filterEnabled = false
    let table = "CommonStrings"
    
    var body: some View {
        List {
            
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
        NewsView()
    }
}