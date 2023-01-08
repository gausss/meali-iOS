import Foundation

struct Meal: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let ingredients: [Ingredient]
    let description: String
    
    func isEmpty() -> Bool {
        id == 0
    }
}

extension Meal {
    static var notFoundMeal: Meal {
        return Meal(id: 0, name: "", ingredients: [], description: "")
    }
}

