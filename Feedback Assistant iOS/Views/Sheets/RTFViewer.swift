//
//  RTFViewer.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct RTFViewer: View {
    let rtfData: Data
    
    var attributedString: AttributedString {
        do {
            let nsAttributedString = try NSAttributedString(
                data: rtfData,
                options: [.documentType: NSAttributedString.DocumentType.rtf],
                documentAttributes: nil
            )
            return try AttributedString(nsAttributedString, including: \.uiKit)
        } catch {
            print("Error loading RTF: \(error)")
            return AttributedString("An error has occurred.")
        }
    }
    
    var body: some View {
        Text(attributedString)
            .padding(5)
    }
}

#Preview {
    RTFViewer(rtfData: Data())
}
