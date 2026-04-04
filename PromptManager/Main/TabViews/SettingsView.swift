import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.requestReview) private var requestReview

    var body: some View {
            Form {
                Section("Legal") {
                    Link(destination: URL(string: "https://apple.com")!) {
                        Label("Terms of Service", systemImage: "doc.text")
                            .foregroundStyle(.primary)
                    }
                    .listRowBackground(Color(uiColor: .systemBackground).opacity(0.5))

                    Link(destination: URL(string: "https://apple.com")!) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                            .foregroundStyle(.primary)
                    }
                    .listRowBackground(Color(uiColor: .systemBackground).opacity(0.5))
                }

                Section("Feedback") {
                    Button {
                        requestReview()
                    } label: {
                        Label("Rate Us", systemImage: "star")
                            .foregroundStyle(.primary)
                    }
                    .listRowBackground(Color(uiColor: .systemBackground).opacity(0.5))
                }
            }
            .scrollContentBackground(.hidden)
            .background(.appBackground)
            .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(termsOfServiceURL: URL(string: "")!, privacyPolicyURL: URL(string: "")!))
}
