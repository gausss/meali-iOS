import SwiftUI

struct MealDetail: View {
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Zutaten")
                .font(.title2)
            Divider()
            Text(meal.ingredients.joined(separator: ", ")).padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            
            Text("Rezept")
                .font(.title2)
            Divider()
            Text(meal.description)
            
            Spacer()
        }.padding()
            .navigationTitle(meal.name)
    }
}
