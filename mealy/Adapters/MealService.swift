import Foundation

class MealService: ObservableObject {
    @Published var meals = JsonStore.readMeals() {
        didSet {
            JsonStore.saveMeals(data: meals)
        }
    }
    
    func getByName(name: String) -> Meal {
        meals.first(where: { $0.id == name}) ?? Meal.notFoundMeal
    }

    func add(name: String, ingredients: [Ingredient], description: String) {
        let newMeal = Meal(id: name, ingredients: ingredients, description: description);
        if let matchIndex = meals.firstIndex(where: { $0.id == name}) {
            meals[matchIndex] = newMeal;
        } else {
            meals.append(newMeal)
        }
    }

    func delete(offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
    }
}
