//
//  SignInView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct SignInView: View {
    // Variables
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
        TextField(NSLocalizedString("SIGN_IN_USERNAME_PLACEHOLDER", tableName: "AppleAccountUI", comment: String()), text: $username)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .padding(.vertical)
            .padding(.leading, 15)
            .frame(height: 48)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding([.horizontal, .top], 30)
        // Forgot password? button
        Button {} label: {
            Text("APPLEID_EXPLANATION", tableName: "AppleAccountUI")
                .font(.subheadline)
                .padding(.top, 6)
        }
        .padding(.bottom, UIDevice.current.model == "iPhone" ? 300 : 150)
        
        // Privacy link button
        Button {} label: {
            VStack {
                Image(_internalSystemName: "privacy.handshake")
                    .resizable()
                    .foregroundStyle(.accent)
                    .scaledToFit()
                    .frame(height: 23)
                Group {
                    Text("CREATE_ICLOUD_MAIL_ACCOUNT_EXPLANATION_FOOTER_REBRAND", tableName: "AppleID") + Text(" ") +  Text("CREATE_ICLOUD_MAIL_ACCOUNT_FOOTER_LEARN_MORE_BUTTON", tableName: "AppleID").foregroundStyle(Color.accent)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.caption2)
                .foregroundStyle(.gray)
                
            }
            .padding(.horizontal, 30)
        }
        .buttonStyle(.plain)
        
        // Continue button
        Button {} label: {
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
    }
}

#Preview {
    SignInView()
}
