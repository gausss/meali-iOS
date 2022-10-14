import Foundation

class PlanService: ObservableObject {
    static let key = "plans"
    
    @Published var plan = JsonStore.readPlan() {
        didSet {
            JsonStore.persist(data: plan, key: PlanService.key)
        }
    }

    func regenerate(meals: [Meal], days: Int) {
        if(meals.isEmpty) {
            return
        }
        
        var newPlan: Set<Meal> = Set()
        while newPlan.count < min(days, meals.count) {
            if let plannedMeal = meals.randomElement() {
                newPlan.insert(plannedMeal)
            }
        }
        
        newPlan.enumerated().forEach { (day, meal) in
            plan.append(PlanItem(mealID: meal.id, day: day + 1))
        }
    }
    
    func clear() {
        plan.removeAll()
    }

    func getIngredients(plan: [PlanItem], meals: [Meal]) -> [String]{
       let planIgredients = plan
           .map {$0.mealID}
           .map { name in meals.first(where: { $0.id == name})}
           .map {$0 ?? Meal.notFoundMeal}
           .map {$0.ingredients}
           .flatMap {$0}
       
        let ingredientMap = Dictionary(grouping: planIgredients, by: { $0.name })
        return ingredientMap.keys
            .map{ingredientMap[$0]}
            .compactMap{$0}
            .map{Ingredient(amount: sumIngredient(ingredients: $0) , unit: $0[0].unit, name: $0[0].name)}
            .sorted {$0.name < $1.name}
            .map{$0.print()}
   }

   private func sumIngredient(ingredients: [Ingredient]) -> String {
       return  String(ingredients.map{Int($0.amount) ?? 0}.reduce(0, +))
   }
}

