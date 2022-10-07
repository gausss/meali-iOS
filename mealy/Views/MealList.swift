import SwiftUI

struct MealList: View {
    @StateObject var mealStore = MealStore()
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(mealStore.meals, id: \.name) { meal in
                    NavigationLink {
                        MealDetail(meal: meal)
                    } label: {
                        Text(meal.name)
                    }
                }.onDelete(perform: mealStore.delete)
            }
            .sheet(isPresented: $isPresented) {
              AddMeal(mealStore: mealStore, showModal: $isPresented)
            }
            .navigationBarItems(trailing:
              Button(action: { isPresented.toggle() }) {
                Image(systemName: "plus")
              })
            .navigationTitle("Gerichte")
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealList(mealStore: MealStore()).preferredColorScheme(.dark)
    }
}
