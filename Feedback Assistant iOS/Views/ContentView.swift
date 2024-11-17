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
    @State private var showingSignInSheet = false
    
    var body: some View {
        ScrollView {
            if UIDevice.current.model == "iPhone" {
                SignInView()
            } else if UIDevice.current.model == "iPad" {
                VStack {}
                    .onAppear {
                        showingSignInSheet.toggle()
                    }
            }
        }
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
                        message: Text("AGREEMENT_REQUIREMENT"),
                        dismissButton: .cancel(Text("OK"))
                    )
                }
                .navigationTitle("Usage Notice")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button("DECLINE") {
                                showingLicenseAlert.toggle()
                            }
                            Spacer()
                            Button("ACCEPT") {
                                showingLicenseSheet.toggle()
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingSignInSheet) {
            SignInView()
        }
    }
}

#Preview {
    ContentView()
}
