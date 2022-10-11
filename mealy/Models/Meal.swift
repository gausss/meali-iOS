import Foundation

struct Meal: Codable, Identifiable, Hashable {
    let id: String
    let ingredients: [Ingredient]
    let description: String
}
