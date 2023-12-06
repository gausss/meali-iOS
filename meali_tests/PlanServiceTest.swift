import XCTest

final class PlanServiceTest: XCTestCase {

    let testMeals = [Meal(id: 1, name: "Lachs", ingredients: [Ingredient(amount: "1", unit: .x, name: "LachsFilet"),Ingredient(amount: "120", unit: .g, name: "Reis")], description: "Test"),
                     Meal(id: 2, name: "Linsen & Spätzle", ingredients: [Ingredient(amount: "200", unit: .g, name: "Linsen"), Ingredient(amount: "300", unit: .g, name: "Spätzle")], description: "Test2"),
                     Meal(id: 3, name: "Linsen Curry", ingredients: [Ingredient(amount: "350", unit: .g, name: "Linsen"), Ingredient(amount: "150", unit: .g, name: "Reis")], description: "Test3")]
    let testPlan = [Suggestion(mealID: 1, day: 0), Suggestion(mealID: 2, day: 1), Suggestion(mealID: 3, day: 2)]
    
    func testPlanGenerationSingleNoPin() throws {
        let planService = PlanService()
        
        planService.regenerate(meals: testMeals, days: 1)
        XCTAssertTrue(planService.plan.count == 1)
    }
    
    func testPlanGenerationMultiWithPin() throws {
        let planService = PlanService()
        planService.plan = testPlan
        
        planService.regenerate(meals: testMeals, days: 3, pinned: [1: true])
        XCTAssertTrue(planService.plan.count == 3)
        XCTAssertTrue(planService.plan[1].mealID == 2)
        XCTAssertTrue(Set(planService.plan.map {$0.mealID}).count == 3)
    }
    
    func testPlanGenerationMultiNoPin() throws {
        let planService = PlanService()

        planService.regenerate(meals: testMeals, days: 4)
        XCTAssertTrue(planService.plan.count == 4)
        XCTAssertTrue(Set(planService.plan.map {$0.mealID}).count == 4)
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
