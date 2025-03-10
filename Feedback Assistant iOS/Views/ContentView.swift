//
//  ContentView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct ContentView: View {
    // Variables
    @AppStorage("AcceptedLicense") private var acceptedLicense = false
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var stateManager: StateManager
    @State var blurRadius: CGFloat = 0
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
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        NavigationStack {
                            stateManager.destination
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
#if DEBUG
            signedIn = true
            showingSignInSheet = false
            showingSignInCover = false
#endif
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
