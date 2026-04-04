import SwiftUI

struct PromptListView: View {
    @EnvironmentObject private var viewModel: PromptViewModel
    
    let showOnlyFavorites: Bool
    
    @State private var showingAddPrompt = false
    
    var body: some View {
        let displayedPrompts = viewModel.filteredPromts(showOnlyFavorites: showOnlyFavorites)
        
        NavigationStack {
            Group {
                if displayedPrompts.isEmpty {
                    ContentUnavailableView(
                        showOnlyFavorites ? "No Favorites": "No Prompts" ,
                        systemImage: showOnlyFavorites ? "star": "books.vertical",
                        description: Text(showOnlyFavorites ? "Add favorite prompts by clicking on the star in the library." : "Add prompts by clicking on the plus in the library."))
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
