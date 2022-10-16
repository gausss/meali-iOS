import Foundation

struct Meal: Codable, Identifiable, Hashable {
    let id: String
    let ingredients: [Ingredient]
    let description: String
    
    func isEmpty() -> Bool {
        id == ""
    }
}

extension Meal {
    static var notFoundMeal: Meal {
        return Meal(id: "", ingredients: [], description: "")
    }
}

