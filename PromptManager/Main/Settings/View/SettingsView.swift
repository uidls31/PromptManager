import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.requestReview) private var requestReview

    var body: some View {
            Form {
                Section("Legal") {
                    Link(destination: viewModel.termsOfServiceURL) {
                        Label("Terms of Service", systemImage: "doc.text")
                            .foregroundStyle(.primary)
                    }
                    .listRowBackground(Rectangle().fill(.ultraThinMaterial))

                    Link(destination: viewModel.privacyPolicyURL) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                            .foregroundStyle(.primary)
                    }
                    .listRowBackground(Rectangle().fill(.ultraThinMaterial))
                }

                Section("Feedback") {
                    Button {
                        requestReview()
                    } label: {
                        Label("Rate Us", systemImage: "star")
                            .foregroundStyle(.primary)
                    }
                    .listRowBackground(Rectangle().fill(.ultraThinMaterial))
                }
            }
            .scrollContentBackground(.hidden)
            .background(.appBackground)
            .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
