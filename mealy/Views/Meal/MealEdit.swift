import SwiftUI
import Combine

struct MealEdit: View {
    @ObservedObject var mealService: MealService
    @State private var name = ""
    @State private var ingredients: [Ingredient] = []
    @State private var description = ""
    let creation: Bool
    
    init(mealService: MealService, meal: Meal) {
        self.mealService = mealService
        self.name = meal.id
        self.ingredients = meal.ingredients
        self.description = meal.description
        self.creation = false
    }
    
    init(mealService: MealService) {
        self.mealService = mealService
        self.creation = true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                if (creation) {
                    Section(header: Text("Name")) {
                        TextField("", text: $name)
                    }
                }
                Section(header: Text("Zutaten")) {
                    List {
                        ForEach(ingredients, id: \.name) { ingredient in
                            Text(ingredient.print())
                        }.onDelete(perform: removeIngredient)
                        
                        IngredientEdit(ingredients: $ingredients)
                    }
                }
                
                Section(header: Text("Rezept")) {
                    TextEditor(text: $description).frame(minHeight: 120)
                }
            }
        }
        .navigationTitle(creation ? "Erstellen" : self.name)
        .onDisappear(perform: {mealService.add(name: name, ingredients: ingredients, description: description)})
    }
    
    private func removeIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}
