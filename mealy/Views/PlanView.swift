import SwiftUI
import RealmSwift

struct PlanView: View {
    @ObservedRealmObject var mealLog: MealLog

    var body: some View {
        NavigationView {
            List {
                ForEach(mealLog.meals) { meal in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(meal.name).font(.title)
                        }
                        Text(meal.ingredients)
                    }
                }
            }.navigationTitle("Dein Plan").listStyle(.inset)
        }
    }
}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(mealLog: MealLog.mealLog1).preferredColorScheme(.dark)
    }
}
