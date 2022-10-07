import SwiftUI
import RealmSwift

struct MealDetail: View {
    @ObservedRealmObject var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.title2)
                Divider()
                TextField("", text: $meal.name)
                    .frame(height: 50)
            }
            
            VStack(alignment: .leading) {
                Text("Zutaten")
                    .font(.title2)
                Divider()
                TextEditor(text: $meal.ingredients).frame(height: 100)
            }
            
            VStack(alignment: .leading) {
                Text("Rezept")
                    .font(.title2)
                Divider()
                TextEditor(text: $meal.recipe)
            }
            
            Spacer()
        }.padding().navigationTitle(!meal.name.isEmpty ? "Bearbeiten" : "Erstellen")


    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail(meal: Meal.meal1).preferredColorScheme(.dark)
    }
}
