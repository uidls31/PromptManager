import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var viewModel: PromptViewModel
    
    var body: some View {
        NavigationStack {
            List {
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(PromptViewModel())
}
