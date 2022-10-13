import Foundation

struct Meal: Codable, Identifiable, Hashable {
    let id: String
    let ingredients: [Ingredient]
    let description: String
}

extension Meal {
    static var notFoundMeal: Meal {
        return Meal(id: "Nicht gefunden", ingredients: [], description: "")
    }
}

