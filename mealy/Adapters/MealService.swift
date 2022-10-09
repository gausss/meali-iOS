import Foundation

class MealService: ObservableObject {
    static let mealServiceKey = "meals"
    static let defaultMeals = [
        Meal(
                name: "Linsen & Spätzle",
                ingredients: ["2 Karotten", "200g Linsen", "1 Zwiebel", "1/2 Lauch", "400g Spätzle", "Gemüsebrühe"],
                description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam.")
        , Meal(
                name: "Quiche",
                ingredients: ["2 Karotten", "200g Linsen", "1 Zwiebel", "1/2 Lauch", "400g Spätzle", "Gemüsebrühe"],
                description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam.")
        , Meal(
                name: "Schweinebraten",
                ingredients: ["2 Karotten", "200g Linsen", "1 Zwiebel", "1/2 Lauch", "400g Spätzle", "Gemüsebrühe"],
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
    
    func getByName(name: String) -> Meal {
        meals.first(where: { $0.name == name}) ?? Meal(name: "Nicht gefunden", ingredients: [], description: "")
    }

    func addMeal(name: String, ingredients: [String], description: String) {
        let newMeal = Meal(name: name, ingredients: ingredients, description: description);
        meals.append(newMeal)
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
