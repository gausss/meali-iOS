import Foundation

struct JsonStore {
    static let mealsKey = "meals"
    static let planKey = "plans"

    static func readPlan() -> [PlanItem] {
        let savedPlan = UserDefaults.standard.object(forKey: planKey)
        if let savedPlan = savedPlan as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([PlanItem].self, from: savedPlan))
                    ?? []
        }
        return []
    }
    
    static func savePlan(data: [PlanItem]) {
        persist(data: data, key: planKey)
    }
    
    static func readMeals() -> [Meal] {
        let savedMeals = UserDefaults.standard.object(forKey: mealsKey)
        if let savedMeals = savedMeals as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Meal].self, from: savedMeals))
                    ?? []
        }
        return []
    }
    
    static func saveMeals(data: [Meal]) {
        persist(data: data, key: mealsKey)
    }
    
    static func persist(data: Codable, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
