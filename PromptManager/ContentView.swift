import SwiftUI

struct ContentView: View {
    
    @State private var isOnboardingComplete = false
    
    var body: some View {
        if isOnboardingComplete {
            MainView()
        } else {
            let viewModel = OnboardingViewModel()
            OnboardingView(viewModel: viewModel)
                .onAppear {
                    viewModel.onFinish = {
                        withAnimation {
                            isOnboardingComplete = true
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
