import SwiftUI

struct PromptListView: View {
    @EnvironmentObject private var viewModel: PromptViewModel
    
    let showOnlyFavorites: Bool
    
    var body: some View {
        NavigationStack {
            let displayedPrompts = viewModel.filteredPromts(showOnlyFavorites: showOnlyFavorites)
            Group {
                if displayedPrompts.isEmpty {
                    ContentUnavailableView(
                        "No favorites",
                        systemImage: "star",
                        description: Text("Add prompts to your favorites by clicking on the star in the library.")
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(displayedPrompts) { prompt in
                                PromptCardView(
                                    prompt: prompt,
                                    onFavoriteTap: {
                                        viewModel.toggleFavorite(prompt)
                                    },
                                    onDeleteTap: {
                                        viewModel.deletePrompt(prompt)
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(showOnlyFavorites ? "Favorites" : "Library")
             .background(.appBackground)
        }
    }
}

#Preview {
    PromptListView(showOnlyFavorites: false)
        .environmentObject(PromptViewModel())
}
