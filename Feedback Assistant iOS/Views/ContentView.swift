//
//  ContentView.swift
//  Feedback Assistant iOS
//

import SwiftUI
import UIKit

struct ContentView: View {
    // Variables
    @State private var showingLicenseSheet = true
    @State private var showingLicenseAlert = false
    
    var body: some View {
        VStack {}
            .sheet(isPresented: $showingLicenseSheet) {
                NavigationStack {
                    ScrollView {
                        if let rtfURL = Bundle.main.url(forResource: "License", withExtension: "rtf"),
                           let rtfData = try? Data(contentsOf: rtfURL) {
                            RTFViewer(rtfData: rtfData)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .alert(isPresented: $showingLicenseAlert) {
                        Alert(
                            title: Text(""),
                            message: Text("You must accept the license agreement before using Feedback Assistant."),
                            dismissButton: .cancel(Text("**OK**"))
                        )
                    }
                    .navigationTitle("Usage Notice")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            HStack {
                                Button("Decline") {
                                    showingLicenseAlert.toggle()
                                }
                                Spacer()
                                Button("Accept") {
                                    showingLicenseSheet.toggle()
                                }
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
