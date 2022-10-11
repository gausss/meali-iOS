import Foundation

class MealService: ObservableObject {
    static let mealServiceKey = "meals"
    static let defaultMeals = [
        Meal(
                id: "Linsen & Spätzle",
                ingredients: [Ingredient(amount: "2", unit: .x, name: "Karotten"), Ingredient(amount: "200", unit: .g, name: "Linsen"), Ingredient(amount: "1", unit: .x, name: "Zwiebel"), Ingredient(amount: "1", unit: .x, name: "Lauch"), Ingredient(amount: "400", unit: .g, name: "Spätzle")],
                description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam.")
        , Meal(
                id: "Quiche",
                ingredients: [Ingredient(amount: "2", unit: .x, name: "Karotten"), Ingredient(amount: "200", unit: .g, name: "Linsen"), Ingredient(amount: "1", unit: .x, name: "Zwiebel"), Ingredient(amount: "1", unit: .x, name: "Lauch"), Ingredient(amount: "400", unit: .g, name: "Spätzle")],
                description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam.")
        , Meal(
                id: "Schweinebraten",
                ingredients: [Ingredient(amount: "2", unit: .x, name: "Karotten"), Ingredient(amount: "200", unit: .g, name: "Linsen"), Ingredient(amount: "1", unit: .x, name: "Zwiebel"), Ingredient(amount: "1", unit: .x, name: "Lauch"), Ingredient(amount: "400", unit: .g, name: "Spätzle")],
                description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam.")
    ]

    private static func getAll() -> [Meal] {
        let savedMeals = UserDefaults.standard.object(forKey: MealService.mealServiceKey)
        if let savedMeals = savedMeals as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Meal].self, from: savedMeals))
                    ?? MealService.defaultMeals
        }
        return MealService.defaultMeals
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
