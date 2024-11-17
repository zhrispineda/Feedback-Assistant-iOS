//
//  ContentView.swift
//  Feedback Assistant iOS
//

import SwiftUI
import UIKit

struct ContentView: View {
    // Variables
    @State private var showingLicenseSheet = true
    @State private var showingSignInSheet = false
    @State private var showingSignInCover = false
    @State private var signedIn = false
    
    var body: some View {
        ZStack {
            if signedIn {
                Color.primary
                    .ignoresSafeArea()
                    .opacity(0.3)
                HStack(spacing: 0.5) {
                    NavigationStack {
                        FeedbackView()
                    }
                    .frame(width: UIDevice.current.model == "iPad" ? 360 : nil)
                    if UIDevice.current.model == "iPad" {
                        NavigationStack {
                            Text("NO_FEEDBACK")
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingLicenseSheet) {
            NavigationStack {
                LicenseView()
                    .onDisappear {
                        if UIDevice.current.model == "iPad" {
                            showingSignInSheet = true
                        } else {
                            showingSignInCover = true
                        }
                    }
            }
        }
        .sheet(isPresented: $showingSignInSheet) {
            SignInView(signedIn: $signedIn)
        }
        .fullScreenCover(isPresented: $showingSignInCover) {
            SignInView(signedIn: $signedIn)
        }
    }
}

#Preview {
    ContentView()
}
