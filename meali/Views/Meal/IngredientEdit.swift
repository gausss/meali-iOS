import SwiftUI

struct IngredientEdit : View {
    @Binding var ingredients: [Ingredient]

    @State private var ingredientAmount: String = "1"
    @State private var ingredientUnit: UnitType = .x
    @State private var ingredientName : String = ""

    var body: some View {
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
    
    private func addIngredient() {
        ingredients.append(Ingredient(amount: ingredientAmount, unit: ingredientUnit, name: ingredientName))
        resetIngredient()
    }
    
    private func resetIngredient() {
        ingredientAmount = "1"
        ingredientUnit = .x
        ingredientName = ""
    }
}
