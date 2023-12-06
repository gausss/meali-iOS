import Foundation

struct MealOld: Codable, Identifiable, Hashable {
    let id: String
    let ingredients: [Ingredient]
    let description: String
}
