import SwiftUI
import Combine

struct MealDetail: View {
    @ObservedObject var mealService: MealService
    @State private var name = ""
    @State private var ingredients: [Ingredient] = []
    @State private var description = ""
    
    @State private var ingredientAmount: String = "1"
    @State private var ingredientUnit: UnitType = .x
    @State private var ingredientName : String = ""

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
                        
                        HStack {
                            Button(action: addIngredient) {
                                Image(systemName: "plus.circle").padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 16))
                            }.disabled(ingredientAmount.isEmpty || ingredientName.isEmpty || ingredients.contains(where: {$0.name == ingredientName}))
                            
                            VStack {
                                HStack {
                                    TextField("Menge", text: $ingredientAmount)
                                        .keyboardType(.numberPad)
                                    
                                    TextField("Zutat", text: $ingredientName)
                                    
                                    Spacer()
                                }.padding(8)
                                
                                Picker("Unit", selection: $ingredientUnit) {
                                    Text("Gramm").tag(UnitType.g)
                                    Text("Milliliter").tag(UnitType.ml)
                                    Text("Stück").tag(UnitType.x)
                                }.pickerStyle(.segmented)
                            }
                        }
                    }
                }
                
                Section(header: Text("Rezept")) {
                    TextEditor(text: $description).frame(minHeight: 120)
                }
            }
        }.navigationTitle(creation ? "Erstellen" : self.name)
            .onDisappear(perform: {mealService.addMeal(name: name, ingredients: ingredients, description: description)})
    }
    
    private func removeIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    private func addIngredient() {
        ingredients.append(Ingredient(amount: ingredientAmount, unit: ingredientUnit, name: ingredientName))
    
        ingredientAmount = "1"
        ingredientUnit = .x
        ingredientName = ""
    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail(mealService: MealService()).preferredColorScheme(.dark)
    }
}
