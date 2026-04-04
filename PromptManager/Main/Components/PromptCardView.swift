import SwiftUI

struct PromptCardView: View {
    let prompt: Prompt
    var onFavoriteTap: () -> Void
    var onDeleteTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                Text(prompt.category.rawValue)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(prompt.category.color, in: Capsule())

                Spacer()

                HStack(spacing: 10) {
                    Button(action: onDeleteTap) {
                        Image(systemName: "trash")
                            .font(.body.weight(.medium))
                            .foregroundStyle(.red)
                            .frame(width: 36, height: 36)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    Button(action: onFavoriteTap) {
                        Image(systemName: prompt.isFavorite ? "star.fill" : "star")
                            .font(.body.weight(.medium))
                            .foregroundStyle(prompt.isFavorite ? Color.yellow : Color.secondary)
                            .frame(width: 36, height: 36)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }

            Text(prompt.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(prompt.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
    }
}

#Preview {
    PromptCardView(
        prompt: Prompt(id: UUID(),
            title: "Код-ревью",
            content: "Проанализируй этот код на баги, риски и читаемость. Ещё немного текста для второй строки.",
            category: .development,
                       isFavorite: true,
                       creationDate: Date()
        ),
        onFavoriteTap: {},
        onDeleteTap: {}
    )
    .padding()
}
