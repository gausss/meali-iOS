import Foundation

public class PlanService: ObservableObject {
    @Published var plan = JsonStore.readPlan() {
        didSet {
            JsonStore.savePlan(data: plan)
        }
    }

    func regenerate(meals: [Meal], days: Int = 4, pinned: [Int: Bool] = [:]) {
        var availableMeals = meals
        if(availableMeals.isEmpty) {
            return
        }
        
        var newPlan: [Meal] = [Meal](repeating: Meal.notFoundMeal, count: days)
        for day in 0..<days {
            if(pinned[day, default: false]) {
                let meal = getMealForDay(meals: availableMeals, day: day)
                newPlan[day] = meal
                availableMeals.removeAll(where: {$0.id == meal.id})
            }
        }
        
        for day in 0..<days {
            if(newPlan[day].isEmpty()) {
                let meal = availableMeals.randomElement() ?? Meal.notFoundMeal
                newPlan[day] = meal
                availableMeals.removeAll(where: {$0.id == meal.id})
            }
        }
        
        plan.removeAll()
        newPlan.enumerated().forEach { (day, meal) in
            plan.append(Suggestion(mealID: meal.id, day: day))
        }
    }
    
    private func getMealForDay(meals: [Meal], day: Int) -> Meal {
        meals.first(where: {$0.id == plan[day].mealID}) ?? Meal.notFoundMeal
    }

    func getIngredients(plan: [Suggestion], meals: [Meal]) -> [Ingredient]{
       let planIgredients = plan
           .map {$0.mealID}
           .map { name in meals.first(where: { $0.id == name})}
           .map {$0 ?? Meal.notFoundMeal}
           .map {$0.ingredients}
           .flatMap {$0}
       
        let ingredientMap = Dictionary(grouping: planIgredients, by: { $0.name.trimmingCharacters(in: .whitespacesAndNewlines) })
        return ingredientMap.keys
            .map{ingredientMap[$0]}
            .compactMap{$0}
            .map{Ingredient(amount: sumIngredient(ingredients: $0) , unit: $0[0].unit, name: $0[0].name)}
            .sorted {$0.name < $1.name}
   }

   private func sumIngredient(ingredients: [Ingredient]) -> String {
       return  String(ingredients.map{Int($0.amount) ?? 0}.reduce(0, +))
   }
}

