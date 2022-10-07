import SwiftUI

struct MealDetail: View {
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(meal.name)
                .font(.title).bold().padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
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
    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail(meal: meals[0]).preferredColorScheme(.dark)
    }
}
