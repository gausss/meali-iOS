import SwiftUI

struct AddMeal: View {

  let mealStore: MealStore
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
        leading:
            Button(action: close) {
            Text("Abbrechen")
          },
        trailing:
          Button(action: addMeal) {
            Text("Hinzufügen")
          }
      )
    }
  }

    private func addMeal() {
        mealStore.addMeal(
            name: name,
            ingredients: ingredients.split(separator: ",").map { String($0) },
            description: description)
        
        close()
    }
    
    private func close() {
      showModal.toggle()
    }
}
