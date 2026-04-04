import Foundation
import Combine

final class PromptViewModel: ObservableObject {

    @Published var prompts: [Prompt] = []

    init() {
        loadMockData()
    }
    
    func filteredPromts(showOnlyFavorites: Bool) -> [Prompt] {
        showOnlyFavorites ? prompts.filter(\.isFavorite) : prompts
    }

    func loadMockData() {
        prompts = [
            Prompt(
                title: "Код-ревью",
                content: "Проанализируй этот код на баги, риски и читаемость. Предложи конкретные правки и краткое резюме.",
                category: .development
            ),
            Prompt(
                title: "Генерация текста",
                content: "Напиши понятный текст для [аудитория] на тему [тема]. Тон: [формальный/дружелюбный]. Объём: [кол-во абзацев].",
                category: .content
            ),
            Prompt(
                title: "Создание логотипа",
                content: "Опиши концепцию логотипа для бренда [название]: стиль, цвета, настроение, где будет использоваться. Дай 3 варианта идеи.",
                category: .design
            ),
            Prompt(
                title: "План на неделю",
                content: "Составь реалистичный план на неделю с учётом приоритетов: [цели]. Разбей по дням, добавь буфер на срывы.",
                category: .productivity
            ),
            Prompt(
                title: "Письмо клиенту",
                content: "Сформулируй вежливое письмо клиенту: [ситуация]. Цель: [что нужно получить]. Без лишней воды.",
                category: .communications,
                isFavorite: true
            ),
            Prompt(
                title: "Разбор ошибки",
                content: "Вот лог/стек: [вставить]. Объясни вероятную причину, шаги диагностики и варианты фикса.",
                category: .development
            ),
        ]
    }

    func toggleFavorite(_ prompt: Prompt) {
        guard let index = prompts.firstIndex(where: { $0.id == prompt.id }) else { return }
        prompts[index].isFavorite.toggle()
    }

    func deletePrompt(_ prompt: Prompt) {
        prompts.removeAll(where: { $0.id == prompt.id })
    }
}
