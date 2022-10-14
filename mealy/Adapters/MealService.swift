import Foundation

class MealService: ObservableObject {
    static let mealServiceKey = "meals"

    private static func getAll() -> [Meal] {
        let savedMeals = UserDefaults.standard.object(forKey: MealService.mealServiceKey)
        if let savedMeals = savedMeals as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Meal].self, from: savedMeals))
                    ?? []
        }
        return []
    }
    
    @Published var meals = getAll() {
        didSet {
            persist()
        }
    }
    
    func getByName(name: String) -> Meal? {
        meals.first(where: { $0.id == name})
    }

    func addMeal(name: String, ingredients: [Ingredient], description: String) {
        let newMeal = Meal(id: name, ingredients: ingredients, description: description);
        if let matchIndex = meals.firstIndex(where: { $0.id == name}) {
            meals[matchIndex] = newMeal;
        } else {
            meals.append(newMeal)
        }
    }

    func delete(at offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
    }

    private func persist() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(meals) {
            UserDefaults.standard.set(encoded, forKey: MealService.mealServiceKey)
        }
    }
}
