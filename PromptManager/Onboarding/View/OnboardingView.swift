import SwiftUI

struct OnboardingView: View {
    
    @StateObject var viewModel = OnboardingViewModel()
    @EnvironmentObject private var coordinator: AppCoordinator
    
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
        .background(.appBackground)
    }
}


#Preview {
    OnboardingView()
        .environmentObject(AppCoordinator())
}

