import SwiftUI

struct PromptDetailView: View {
    
    let prompt: Prompt
    
    @EnvironmentObject private var viewModel: PromptViewModel
    
    @State private var copyButtonTitle = "Copy Prompt"
    private var currentPrompt: Prompt {
        viewModel.prompts.first(where: { $0.id == prompt.id }) ?? prompt
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(currentPrompt.category.rawValue)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(currentPrompt.category.color, in: Capsule())
                
                Text(currentPrompt.title)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(currentPrompt.content)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
    
                Button {
                    UIPasteboard.general.string = currentPrompt.content
                    copyButtonTitle = "Copied!"
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        copyButtonTitle = "Copy Prompt"
                    }
                } label: {
                    Text(copyButtonTitle)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                .padding(.top, 8)
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(.appBackground)
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        viewModel.toggleFavorite(currentPrompt)
                    }
                } label: {
                    Image(systemName: currentPrompt.isFavorite ? "star.fill" : "star")
                        .foregroundStyle(currentPrompt.isFavorite ? Color.yellow : Color.primary)
                }
            }
        }
    }
}



#Preview {
    NavigationStack {
        PromptDetailView(
            prompt: Prompt(
                title: "Preview",
                content: "Long sample prompt text for preview.",
                category: .development
            )
        )
        .environmentObject(PromptViewModel())
        
    }
}
