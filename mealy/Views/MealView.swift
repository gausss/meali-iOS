import SwiftUI
import RealmSwift

struct MealView: View {
    @ObservedRealmObject var mealLog: MealLog
    @State private var isShowingDetailView = false
    @State private var lastAdded : Meal = Meal()

    var body: some View {
        NavigationView {
            List {
                ForEach(mealLog.meals) { meal in
                    NavigationLink {
                        MealDetail(meal: meal)
                    } label: {
                        Text(meal.name)
                    }
                }.onDelete(perform: $mealLog.meals.remove)
                    .onMove(perform: $mealLog.meals.move)
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: MealDetail(meal: lastAdded), isActive: $isShowingDetailView) {
                Button(action: {
                lastAdded = Meal()
                $mealLog.meals.append(lastAdded)
                isShowingDetailView.toggle()
            }) { Image(systemName: "plus") }
                
            })
            .navigationTitle("Gerichte")
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(mealLog: MealLog.mealLog1).preferredColorScheme(.dark)
    }
}
