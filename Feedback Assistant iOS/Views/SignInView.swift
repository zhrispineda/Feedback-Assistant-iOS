//
//  SignInView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct SignInView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @Binding var signedIn: Bool
    @State private var username = String()
    
    var body: some View {
        Image("RoundedIcon") // Rounded Icon
            .resizable()
            .scaledToFit()
            .frame(width: 80)
        Text("FEEDBACK_ASSISTANT") // Feedback Assistant Title
            .font(.title)
            .fontWeight(.bold)
        // Email or Phone Number text field
        TextField(NSLocalizedString("SIGN_IN_USERNAME_PLACEHOLDER", tableName: "AppleAccountUI", comment: ""), text: $username)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .padding(.vertical)
            .padding(.leading, 15)
            .frame(height: 48)
            .background(UIDevice.current.userInterfaceIdiom == .pad ? Color(UIColor.systemGray5) : Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding([.horizontal, .top], 30)
        // Forgot password? button
        Button {} label: {
            Text("APPLEID_EXPLANATION", tableName: "AppleAccountUI")
                .font(.subheadline)
                .padding(.top, 6)
        }
        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 300 : 150)
        
        // Privacy link button
        OBPrivacyLinkView()
            .frame(minHeight: 100)
            .padding(.horizontal, 30)
        
        // Continue button
        Button {
            dismiss()
            signedIn = true
        } label: {
            Text("SIGN_IN_BUTTON_CONTINUE", tableName: "AppleAccountUI")
                .fontWeight(.semibold)
                .font(.subheadline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(username.count < 1 ? Color(UIColor.systemGray5) : Color.accent)
                .foregroundStyle(username.count < 1 ? Color(UIColor.systemGray) : Color.white)
                .cornerRadius(15)
        }
        .frame(height: 50)
        .padding(.horizontal, 30)
        .disabled(username.count < 1)
    }
}

struct OBPrivacyLinkView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        guard let handle = dlopen("/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit", RTLD_LAZY) else {
            return UIViewController()
        }
        defer { dlclose(handle) }
        
        guard let controller = NSClassFromString("OBPrivacyLinkController") as? NSObject.Type else {
            return UIViewController()
        }
        
        let selector = NSSelectorFromString("linkWithBundleIdentifier:")
        let bundleIdentifiers = "com.apple.onboarding.appleid"
        let result = (controller.perform(selector, with: bundleIdentifiers)?.takeUnretainedValue() as? UIViewController)!
        return result
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    SignInView(signedIn: .constant(false))
}
