import SwiftUI

struct MealView: View {
    @ObservedObject var mealService : MealService
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
                if(mealService.meals.isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Du hast noch keine Gerichte erstellt.").font(.title2)
                        Image("Ravioli").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }
                
                List {
                    ForEach(mealService.meals, id: \.id) { meal in
                        NavigationLink {
                            MealEdit(mealService: mealService, meal: meal)
                        } label: {
                            Text(meal.id)
                        }
                    }.onDelete(perform: mealService.delete)
                }.listStyle(.plain)
                
                NavigationLink(destination: MealEdit(mealService: mealService), isActive: $isPresented) { EmptyView() }
                Button(action: {isPresented.toggle()}) {
                    Label("Hinzufügen", systemImage: "plus")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule)
            }
            .navigationTitle("Gerichte")
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
        }
    }
}
