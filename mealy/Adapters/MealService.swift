import Foundation

class MealService: ObservableObject {
    static let key = "meals"
    
    @Published var meals = JsonStore.readMeals() {
        didSet {
            JsonStore.persist(data: meals, key: MealService.key)
        }
    }
    
    func getByName(name: String) -> Meal {
        meals.first(where: { $0.id == name}) ?? Meal.notFoundMeal
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
}
