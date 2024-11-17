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
    
    var body: some View {
        List {
            
        }
        .navigationTitle("Recent Activity")
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
                            Text("Filtered by:")
                                .font(.subheadline)
                            Button("Open") {}
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
