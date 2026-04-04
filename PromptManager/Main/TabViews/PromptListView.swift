import SwiftUI

struct PromptListView: View {
    @EnvironmentObject private var viewModel: PromptViewModel
    
    let showOnlyFavorites: Bool
    
    @State private var showingAddPrompt = false
    
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
                                NavigationLink {
                                    PromptDetailView(prompt: prompt)
                                } label: {
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
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $showingAddPrompt) {
                AddPromptView()
                    .environmentObject(viewModel)
            }
            .navigationTitle(showOnlyFavorites ? "Favorites" : "Library")
            .toolbar {
                if !showOnlyFavorites {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingAddPrompt = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("Add prompt")
                    }
                }
            }
            .background(.appBackground)
        }
    }
}

#Preview {
    PromptListView(showOnlyFavorites: false)
        .environmentObject(PromptViewModel())
}
