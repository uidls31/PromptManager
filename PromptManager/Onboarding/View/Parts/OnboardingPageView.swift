import SwiftUI

struct OnboardingPageView: View {
    let symbol: String
    let title: String
    let description: String
    var body: some View {
        
        VStack(spacing: 18) {
            Spacer()
                .frame(height: UIScreen.main.isSmallScreen ? 80 : 150)

            ZStack {
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .strokeBorder(.white.opacity(0.18), lineWidth: 1)
                    )

                Image(systemName: symbol)
                    .font(.system(size: 72, weight: .semibold, design: .rounded))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                    .padding(32)
            }
            .frame(height: 180)
            .shadow(color: .black.opacity(0.22), radius: 20, y: 10)

            VStack(spacing: 18) {
                Text(title)
                    .font(.system(.largeTitle, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)

                Text(description)
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.white.opacity(0.92))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, 10)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 24)
    }
}

#Preview {
    OnboardingPageView(symbol: "sparkles.rectangle.stack", title: "Сохраняй лучшие промпты", description: "Добавляй удачные запросы к ИИ в коллекцию, чтобы быстро повторять результат и не писать всё заново.")
}
