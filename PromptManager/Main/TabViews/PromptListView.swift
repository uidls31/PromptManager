import SwiftUI

struct PromptListView: View {
    @ObservedObject var viewModel: PromptViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    let showOnlyFavorites: Bool
    
    @State private var showingAddPrompt = false
    
    var body: some View {
        let displayedPrompts = viewModel.filteredPromts(showOnlyFavorites: showOnlyFavorites)
        
        NavigationStack(path: $coordinator.path) {
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
                                Button(action: {
                                    coordinator.push(.detail(prompt))
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
            .navigationTitle(showOnlyFavorites ? "Favorites" : "Library")
            .toolbar(content: {
                if !showOnlyFavorites {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            coordinator.presentSheet(.addPrompt)
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
            })
            .background(.appBackground)
            .navigationDestination(for: AppScreen.self) { screen in
                switch screen {
                case .detail(let prompt):
                    PromptDetailView(prompt: prompt)
                }
            }
        }
    }
}

#Preview {
    PromptListView(viewModel: PromptViewModel(), showOnlyFavorites: false)
//        .environmentObject(PromptViewModel())
        .environmentObject(AppCoordinator())
}
