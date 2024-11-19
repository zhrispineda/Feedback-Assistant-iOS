//
//  ContentView.swift
//  Feedback Assistant iOS
//

import SwiftUI
import UIKit

struct ContentView: View {
    // Variables
    @Environment(\.scenePhase) var scenePhase
    @State var blurRadius : CGFloat = 0
    @AppStorage("AcceptedLicense") private var acceptedLicense = false
    @State private var showingLicenseSheet = false
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
        .blur(radius: blurRadius)
        .onAppear {
            showingLicenseSheet = !acceptedLicense
            if acceptedLicense {
                if UIDevice.current.model == "iPad" {
                    showingSignInSheet = true
                } else {
                    showingSignInCover = true
                }
            }
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active, .inactive:
                blurRadius = 0
            case .background:
                blurRadius = 25
            @unknown default:
                blurRadius = 0
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
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingSignInSheet) {
            SignInView(signedIn: $signedIn)
                .interactiveDismissDisabled()
        }
        .fullScreenCover(isPresented: $showingSignInCover) {
            SignInView(signedIn: $signedIn)
        }
    }
}

#Preview {
    ContentView()
}
