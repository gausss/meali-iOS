import SwiftUI

struct AddMeal: View {

  let mealService: MealService
  @Binding var showModal: Bool
  @State private var name = ""
  @State private var ingredients = ""
  @State private var description = ""

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Name")) {
          TextField("", text: $name)
        }
        Section(header: Text("Zutaten")) {
            TextEditor(text: $ingredients)
        }
        Section(header: Text("Rezept")) {
            TextEditor(text: $description)
        }
      }
      .navigationBarTitle(Text("Gericht hinzufügen"), displayMode: .inline)
      .navigationBarItems(
        trailing:
          Button(action: addMeal) {
              Image(systemName: "checkmark.circle")
          }
      )
    }
  }

    private func addMeal() {
        mealService.addMeal(
            name: name,
            ingredients: ingredients.split(separator: ",").map { String($0) },
            description: description)
        close()
    }
    
    private func close() {
      showModal.toggle()
    }
}
