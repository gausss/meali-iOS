import Foundation

struct Meal: Codable, Identifiable, Hashable {
    let id: String
    let ingredients: [String]
    let description: String
}
