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
}

