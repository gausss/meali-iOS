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

    let heading: String
    
    init(mealService: MealService, meal: Meal) {
        self.mealService = mealService
        self.name = meal.id
        self.ingredients = meal.ingredients
        self.description = meal.description
        self.heading = "Bearbeiten"
    }
    
    init(mealService: MealService) {
        self.mealService = mealService
        self.heading = "Erstellen"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Name")) {
                    TextField("", text: $name)
                }
                Section(header: Text("Rezept")) {
                    TextEditor(text: $description)
                }
                Section(header: Text("Zutaten")) {
                    List {
                        ForEach(ingredients, id: \.name) { ingredient in
                            Text(ingredient.print())
                        }.onDelete(perform: removeIngredient)
                        
                        VStack {
                            HStack {
                                TextField("Menge", text: $ingredientAmount)
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(ingredientAmount)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.ingredientAmount = filtered
                                        }
                                    }
                                
                                TextField("Zutat", text: $ingredientName)
                                
                                Spacer()
                            }.padding(8)
                            
                            Picker("Unit", selection: $ingredientUnit) {
                                Text("Gramm").tag(UnitType.g)
                                Text("Milliliter").tag(UnitType.ml)
                                Text("Stück").tag(UnitType.x)
                            }.pickerStyle(.segmented)
                        }
                        
                        Button(action: addIngredient) {
                            Image(systemName: "plus")
                        }.disabled(ingredientAmount.isEmpty || ingredientName.isEmpty)
                    }
                }
            }
        }.navigationTitle(heading)
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
