//
//  LicenseView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct LicenseView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var showingLicenseAlert = false
    
    var body: some View {
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
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    LicenseView()
}
