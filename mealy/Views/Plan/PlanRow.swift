import SwiftUI

struct PlanRow: View {
    var day: Int
    var meal: Meal
    
    var body: some View {
        HStack {
            Text("\(day)").font(.largeTitle).foregroundColor(Color.gray).bold().padding(12)
            
            VStack(alignment: .leading) {
                Text(meal.id).font(.title2).bold()
                
                Text(meal.ingredients.map({$0.print()}).joined(separator: ", "))
            }
        }
    }
}

