import Foundation

class MealService: ObservableObject {
    @Published var meals = JsonStore.readMeals() {
        didSet {
            JsonStore.saveMeals(data: meals)
        }
    }
    
    func getByID(ID: Int) -> Meal {
        meals.first(where: { $0.id == ID}) ?? Meal.notFoundMeal
    }

    func save(ID: Int, name: String, ingredients: [Ingredient], description: String) {
        let newMeal = Meal(id: ID, name: name, ingredients: ingredients, description: description)
        if let matchIndex = meals.firstIndex(where: { $0.id == ID}) {
            meals[matchIndex] = newMeal;
        } else {
            meals.append(newMeal)
        }
    }

    func delete(offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
    }
    
    func generateID() -> Int {
        let ID = JsonStore.readID() + 1
        JsonStore.saveID(data: ID)
        return ID
    }
}
