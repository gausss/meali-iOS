import Foundation

class MigrationService {
    
    func migrate() {
        print("Starting migration")
    }
    
    func migrateToV2() {
        let mealsOld = readMealsOld();
        let meals = mealsOld.map{Meal(id: generateID(), name: $0.id, ingredients: $0.ingredients, description: $0.description)}
        meals.forEach{ print("Migrated \($0.name) to \($0.id)") }
        
        JsonStore.saveMeals(data: meals)
        JsonStore.savePlan(data: [])
    }
    
    func readMealsOld() -> [MealOld] {
        let oldMeals = UserDefaults.standard.object(forKey: "meals")
        if let meals = oldMeals as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([MealOld].self, from: meals))
            ?? []
        }
        return []
    }
        
    func generateID() -> Int {
        let ID = JsonStore.readID() + 1
        JsonStore.saveID(data: ID)
        return ID
    }
}
