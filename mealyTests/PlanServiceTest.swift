import XCTest

final class PlanServiceTest: XCTestCase {

    let testMeals = [Meal(id: "Lachs", ingredients: [Ingredient(amount: "1", unit: .x, name: "LachsFilet"),Ingredient(amount: "120", unit: .g, name: "Reis")], description: "Test"),
                     Meal(id: "Linsen & Spätzle", ingredients: [Ingredient(amount: "200", unit: .g, name: "Linsen"), Ingredient(amount: "300", unit: .g, name: "Spätzle")], description: "Test2"),
                     Meal(id: "Linsen Curry", ingredients: [Ingredient(amount: "350", unit: .g, name: "Linsen"), Ingredient(amount: "150", unit: .g, name: "Reis")], description: "Test3")]
    let testPlan = [PlanItem(mealID: "Lachs", day: 0), PlanItem(mealID: "Linsen & Spätzle", day: 1), PlanItem(mealID: "Linsen Curry", day: 2)]
    
    func testPlanGeneration() throws {
        let planService = PlanService()
        
        planService.regenerate(meals: testMeals, days: 1)
        XCTAssertTrue(planService.plan.count == 1)
        
        planService.regenerate(meals: testMeals, days: 3)
        XCTAssertTrue(planService.plan.count == 3)
        XCTAssertTrue(Set(planService.plan.map {$0.mealID}).count == 3)

        
        planService.regenerate(meals: testMeals, days: 4)
        XCTAssertTrue(planService.plan.count == 3)
        XCTAssertTrue(Set(planService.plan.map {$0.mealID}).count == 3)
    }
    
    func testIngredientList() throws {
        let planService = PlanService()
        
        let ingredients = planService.getIngredients(plan: testPlan, meals: testMeals)
        XCTAssertTrue(ingredients.count == 4)
        XCTAssertTrue(ingredients.contains(Ingredient(amount: "270", unit: .g, name: "Reis")))
        XCTAssertTrue(ingredients.contains(Ingredient(amount: "550", unit: .g, name: "Linsen")))
        XCTAssertTrue(ingredients.contains(Ingredient(amount: "1", unit: .x, name: "LachsFilet")))
        XCTAssertTrue(ingredients.contains(Ingredient(amount: "300", unit: .g, name: "Spätzle")))
        
        var smallerTestPlan = testPlan
        smallerTestPlan.removeLast()
        let ingredientsSmaller = planService.getIngredients(plan: smallerTestPlan, meals: testMeals)
        XCTAssertTrue(ingredientsSmaller.count == 4)
        XCTAssertTrue(ingredientsSmaller.contains(Ingredient(amount: "120", unit: .g, name: "Reis")))
        XCTAssertTrue(ingredientsSmaller.contains(Ingredient(amount: "200", unit: .g, name: "Linsen")))
        XCTAssertTrue(ingredientsSmaller.contains(Ingredient(amount: "1", unit: .x, name: "LachsFilet")))
        XCTAssertTrue(ingredientsSmaller.contains(Ingredient(amount: "300", unit: .g, name: "Spätzle")))
        
    }


}
