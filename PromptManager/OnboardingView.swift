import SwiftUI

struct OnboardingView: View {
    private struct OnboardingPage: Identifiable {
        let id = UUID()
        let symbol: String
        let title: String
        let description: String
    }

    private let pages: [OnboardingPage] = [
        .init(
            symbol: "sparkles.rectangle.stack",
            title: "Сохраняй лучшие промпты",
            description: "Добавляй удачные запросы к ИИ в коллекцию, чтобы быстро повторять результат и не писать всё заново."
            
        ),
        .init(
            symbol: "wand.and.stars",
            title: "Улучшай ответы постепенно",
            description: "Версии, заметки и небольшие правки помогают довести промпт до идеала — и всегда иметь под рукой рабочий вариант."
        ),
        .init(
            symbol: "tray.and.arrow.down.fill",
            title: "Доступ в один тап",
            description: "Храни промпты структурировано и используй их, когда нужно: для работы, учебы и творчества."
        ),
    ]

    @State private var selection = 0

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
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            TabView(selection: $selection) {
                ForEach(Array(pages.enumerated()), id: \.offset) { idx, page in
                    OnboardingPageView(
                        symbol: page.symbol,
                        title: page.title,
                        description: page.description,
                        showsStartButton: idx == pages.count - 1,
                        onStart: {
                            print("Onboarding started")
                        }
                    )
                    .tag(idx)
                    .padding(.horizontal, 20)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

private struct OnboardingPageView: View {
    let symbol: String
    let title: String
    let description: String
    let showsStartButton: Bool
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            Spacer(minLength: 10)

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

            Spacer()

            if showsStartButton {
                Button(action: onStart) {
                    Text("Начать")
                        .font(.system(.headline, design: .rounded).weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .buttonStyle(StartButtonStyle())
                .padding(.bottom, 18)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                Spacer(minLength: 62)
            }
        }
        .animation(.spring(response: 0.45, dampingFraction: 0.85), value: showsStartButton)
    }
}

private struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.43, green: 0.28, blue: 0.98),
                        Color(red: 0.10, green: 0.55, blue: 0.98),
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(.white.opacity(configuration.isPressed ? 0.18 : 0.24), lineWidth: 1)
            )
            .shadow(color: .black.opacity(configuration.isPressed ? 0.10 : 0.20), radius: 18, y: 10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    OnboardingView()
}

