//
//  SettingsView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("SignedIn") private var signedIn = false
    @AppStorage("NeedsSignInPad") private var needsSignInPad = false
    @AppStorage("NeedsSignInPhone") private var needsSignInPhone = false
    @Binding var showingSettingsSheet: Bool
    @State private var showingResetWarning = false
    @State private var useFaceID = false
    @State private var useCellularData = false
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 42))
                        .foregroundStyle(.white, .gray.gradient)
                    VStack(alignment: .leading) {
                        Text("John Appleseed")
                        Text(verbatim: "j.appleseed@icloud.com")
                            .foregroundStyle(.gray)
                    }
                    .font(.subheadline)
                }
                Button("Sign Out") {
                    signedIn = false
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        needsSignInPad = true
                    } else {
                        needsSignInPhone = true
                    }
                }
                .foregroundStyle(.red)
            }
            
            Section {
                NavigationLink("PAIRING_VIEW_TITLE") {}
                Toggle("CELL_FILE_UPLOADS", isOn: $useCellularData)
            } footer: {
                Text("CELLULAR_DATA_INFO_FOOTER")
            }
            
            Section {
                Toggle("FACE_ID_PREFERENCE", isOn: $useFaceID)
            }
            
            Section {
                Button("RESET_WARNINGS") {
                    
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    showingSettingsSheet.toggle()
                }
                .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showingSettingsSheet: .constant(true))
    }
}
