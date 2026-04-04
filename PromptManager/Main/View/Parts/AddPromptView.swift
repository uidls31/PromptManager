import SwiftUI

struct AddPromptView: View {
    @ObservedObject var viewModel: PromptViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var category: Category = .development
    
    private var canSave: Bool {
        !title.isEmpty && !content.isEmpty
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 16) {
                        TextField("Title", text: $title)
                        
                        Divider()
                            .background(.white.opacity(0.3))
                        
                        TextField("Content", text: $content, axis: .vertical)
                            .lineLimit(4...12)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker("", selection: $category) {
                            ForEach(Category.allCases, id: \.self) { value in
                                Text(value.rawValue).tag(value)
                            }
                        }
                        .tint(.primary)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                }
                .padding()
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(.appBackground)
            
            .navigationTitle("New Prompt")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addPrompt(title: title, content: content, category: category)
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
}

#Preview {
    AddPromptView(viewModel: PromptViewModel(userDefaultsService: UserDefaultsService()))
}
