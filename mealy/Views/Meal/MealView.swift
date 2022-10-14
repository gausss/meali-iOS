import SwiftUI

struct MealView: View {
    @ObservedObject var mealService : MealService
    @State private var isPresented = false
    @State private var query = ""

    var body: some View {
        NavigationView {
            VStack {
                if(getMeals().isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Keine Gerichte gefunden.").font(.title2)
                        Image("Ravioli").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }
                
                List {
                    ForEach(getMeals(), id: \.id) { meal in
                        NavigationLink {
                            MealEdit(mealService: mealService, meal: meal)
                        } label: {
                            Text(meal.id)
                        }
                    }.onDelete(perform: mealService.delete)
                }.listStyle(.plain)
                    .searchable(text: $query)
                
                NavigationLink(destination: MealEdit(mealService: mealService), isActive: $isPresented) { EmptyView() }
                Button(action: {isPresented.toggle()}) {
                    Label("Hinzufügen", systemImage: "plus")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule)
            }
            .navigationTitle("Gerichte")
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
        }
    }
    
    func getMeals() -> [Meal] {
        if(query.isEmpty) {
            return mealService.meals
        }
        
        return mealService.meals.filter{$0.id.contains(query)}
    }
}
