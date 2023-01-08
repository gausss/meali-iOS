import SwiftUI
import Combine

struct MealEdit: View {
    @ObservedObject var mealService: MealService
    @State private var name = ""
    @State private var ingredients: [Ingredient] = []
    @State private var description = ""
    private let ID: Int
    
    init(mealService: MealService, meal: Meal) {
        self.mealService = mealService
        self.name = meal.name
        self.ingredients = meal.ingredients
        self.description = meal.description
        self.ID = meal.id
    }
    
    init(mealService: MealService) {
        self.mealService = mealService
        self.ID = 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    TextField("", text: $name)
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
        .navigationTitle(ID == 0 ? "Erstellen" : self.name)
        .onDisappear(perform: {mealService.save(ID: ID != 0 ? ID : mealService.generateID(), name: name, ingredients: ingredients, description: description)})
    }
    
    private func removeIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}
