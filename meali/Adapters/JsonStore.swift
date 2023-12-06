import Foundation

struct JsonStore {
    static let mealsKey = "mealsv2"
    static let planKey = "plans"
    static let idKey = "ids"
    
    static func readID() -> Int {
        let currentID = UserDefaults.standard.object(forKey: idKey)
        if let id = currentID as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode(Int.self, from: id))
                    ?? 0
        }
        return 0
    }
    
    static func saveID(data: Int) {
        persist(data: data, key: idKey)
    }
    

    static func readPlan() -> [Suggestion] {
        let savedPlan = UserDefaults.standard.object(forKey: planKey)
        if let plan = savedPlan as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Suggestion].self, from: plan))
                    ?? []
        }
        return []
    }
    
    static func savePlan(data: [Suggestion]) {
        persist(data: data, key: planKey)
    }
    
    static func readMeals() -> [Meal] {
        let savedMeals = UserDefaults.standard.object(forKey: mealsKey)
        if let meals = savedMeals as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Meal].self, from: meals))
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
