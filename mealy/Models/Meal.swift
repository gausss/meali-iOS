import RealmSwift

final class Meal: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var ingredients: String
    @Persisted var recipe: String
    @Persisted(originProperty: "meals") var mealLog: LinkingObjects<MealLog>
}

final class MealLog: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var meals = RealmSwift.List<Meal>()
}

extension MealLog {
    static let mealLog1 = MealLog(value: ["meals": [["name": "Linsen", "ingredients": "2 Karotten, 500g Linsen", "recipe": "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentu."], ["name": "Spaghetti", "ingredients": "Tomatensoße, 500g Spaghetti", "recipe": "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentu."]]])
    
}

extension Meal {
    static let meal1 = Meal(value: ["name": "Linsen", "ingredients": "2 Karotten, 500g Linsen", "recipe": "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentu."])
    static let meal2 = Meal(value: ["name": "Spaghetti", "ingredients": "Tomatensoße, 500g Spaghetti", "recipe": "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentu."])
    
}
