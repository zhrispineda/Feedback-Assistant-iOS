//
//  FeedbackReadDraftView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct FeedbackReadDraftView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentFeedback = FeedbackType(platform: "", subtitle: "")
    @State private var showingEditSheet = false
    @State private var showingDeleteDialog = false
    let fbData = FeedbackHelper()
    var feedback: FeedbackType
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading) {
                    Text(feedback.title.isEmpty ? "Untitled Feedback" : feedback.title)
                        .font(.headline)
                        .padding(.bottom, 8)
                    Divider()
                    Text("BASIC INFORMATION")
                        .padding(.bottom, 5)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("Please provide a descriptive title for your feedback:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(feedback.title.isEmpty ? "Untitled Feedback\n" : feedback.title + "\n")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Which area are you seeing an issue with?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(feedback.productArea == .none ? "No answer provided\n" : "\(feedback.productArea.rawValue)\n")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("What type of feedback are you reporting?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(feedback.productType.isEmpty ? "No answer provided\n" : "\(feedback.productType)\n")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Divider()
                    Text("DESCRIPTION")
                        .padding(.bottom, 5)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("Please describe the issue and what steps we can take to reproduce it:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(feedback.description.isEmpty ? "No answer provided" : feedback.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .confirmationDialog("Are you sure you want to delete this draft? This cannot be undone.", isPresented: $showingDeleteDialog) {
                    Button("Delete Draft", role: .destructive) {
                        fbData.deleteFeedbackById(withId: feedback.id)
                        dismiss()
                    }
                } message: {
                    Text("Are you sure you want to delete this draft? This cannot be undone.")
                }
                .onAppear {
                    currentFeedback = feedback
                }
                .sheet(isPresented: $showingEditSheet) {
                    NavigationStack {
                        FeedbackDraftView(currentFeedback: $currentFeedback)
                    }
                }
            }
            .contentMargins(.top, 0)
            .listStyle(.grouped)
            .navigationTitle(feedback.title.isEmpty ? "Untitled Feedback" : feedback.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("", systemImage: "ellipsis.circle") {
                        Button("Edit Draft", systemImage: "bubble.and.pencil") {
#if DEBUG
                            print("[FeedbackReadDraftView] Editing draft for:\n\(feedback)")
#endif
                            showingEditSheet.toggle()
                        }
                        Button("Delete Draft", systemImage: "trash", role: .destructive) {
                            showingDeleteDialog.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FeedbackReadDraftView(feedback: FeedbackType(platform: "Platform", subtitle: "Subtitle"))
}
