import Foundation

class PlanService: ObservableObject {
    static let planServiceKey = "plans"
    
    private static func getAll() -> [PlanItem] {
        let savedPlan = UserDefaults.standard.object(forKey: PlanService.planServiceKey)
        if let savedPlan = savedPlan as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([PlanItem].self, from: savedPlan))
                    ?? []
        }
        return []
    }
    
    @Published var plan = getAll() {
        didSet {
            persist()
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

    private func persist() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(plan) {
            UserDefaults.standard.set(encoded, forKey: PlanService.planServiceKey)
        }
    }
    
    func getIngredientList(plan: [PlanItem], meals: [Meal]) -> [String]{
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
            .map{$0.print()}
   }

   private func sumIngredient(ingredients: [Ingredient]) -> String {
       return  String(ingredients.map{Int($0.amount) ?? 0}.reduce(0, +))
   }
}

