import SwiftUI

struct PromptListView: View {
    @ObservedObject var viewModel: PromptViewModel
    let showOnlyFavorites: Bool
    
    var body: some View {
        let displayedPrompts = viewModel.filteredPromts(showOnlyFavorites: showOnlyFavorites)
        
            Group {
                if displayedPrompts.isEmpty {
                    ContentUnavailableView(
                        showOnlyFavorites ? "No Favorites": "No Prompts" ,
                        systemImage: showOnlyFavorites ? "star": "folder.fill",
                        description: Text(showOnlyFavorites ? "Add favorite prompts by clicking on the star in the prompts." : "Add prompts by clicking on the plus."))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(displayedPrompts) { prompt in
                                Button(action: {
                                    viewModel.didSelectPrompt(prompt)
                                }, label: {
                                    PromptCardView(
                                        prompt: prompt,
                                        onFavoriteTap: {
                                            viewModel.toggleFavorite(prompt)
                                        },
                                        onDeleteTap: {
                                            viewModel.deletePrompt(prompt)
                                        }
                                    )
                                })
                                
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(showOnlyFavorites ? "Favorites" : "Prompts")
            .toolbar(content: {
                if !showOnlyFavorites {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.didTapAddPrompt()
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
            })
            .background(.appBackground)
    }
}
