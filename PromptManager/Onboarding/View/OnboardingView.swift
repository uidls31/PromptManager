import SwiftUI

struct OnboardingView: View {
    
    @StateObject var viewModel: OnboardingViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    private let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.33, green: 0.29, blue: 0.98),
            Color(red: 0.10, green: 0.55, blue: 0.98),
            Color(red: 0.36, green: 0.83, blue: 0.88),
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $viewModel.selection) {
                    ForEach(viewModel.pages) { page in
                        OnboardingPageView(
                            symbol: page.symbol,
                            title: page.title,
                            description: page.description)
                        .tag(page.id)
                        .padding(.horizontal, 20)
                    }
                }
                .tabViewStyle(.page)
            }
            
            Button {
                withAnimation {
                    viewModel.nextPage(coordinator: coordinator)
                }
            } label: {
                Text(viewModel.selection == viewModel.lastPageID ? "Get Started" : "Next")
                    .font(.system(.headline, design: .rounded).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 18)
            .padding(.horizontal, 16)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .background(backgroundGradient)
    }
}


#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}

