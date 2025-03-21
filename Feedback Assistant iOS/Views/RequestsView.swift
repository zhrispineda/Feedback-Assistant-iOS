//
//  RequestsView.swift
//  Feedback Assistant iOS
//
//  Feedback Assistant > Requests
//

import SwiftUI

struct RequestsView: View {
    // Variables
    @State private var searchText = String()
    @State private var filterEnabled = false
    let table = "CommonStrings"
    
    var body: some View {
        List {
            
        }
        .navigationTitle("REQUESTS_FILTER".localize(table: table))
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
        RequestsView()
    }
}
