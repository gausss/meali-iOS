import Foundation

struct JsonStore {
   
    static func readPlan() -> [PlanItem] {
        let savedPlan = UserDefaults.standard.object(forKey: PlanService.key)
        if let savedPlan = savedPlan as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([PlanItem].self, from: savedPlan))
                    ?? []
        }
        return []
    }
    
    static func readMeals() -> [Meal] {
        let savedMeals = UserDefaults.standard.object(forKey: MealService.key)
        if let savedMeals = savedMeals as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Meal].self, from: savedMeals))
                    ?? []
        }
        return []
    }
    
    static func persist(data: Codable, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
