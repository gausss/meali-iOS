import SwiftUI

struct PlanRow: View {
    var day: Int
    var meal: Meal
    @Binding var pinned: [Int: Bool]
    
    var body: some View {
        Button(action: pin) {
            HStack {
                Text("\(day + 1)").font(.largeTitle).foregroundColor(Color.gray).bold().padding(12)
                
                Text(meal.name).font(.title2).bold()
                
                Spacer()
                
                if(!meal.isEmpty()) {
                    Image(systemName: pinned[day, default: false] ? "pin.fill": "pin.slash").foregroundColor(.accentColor)
                }
            }
        }.disabled(meal.isEmpty())
    }
    
    private func pin() {
        pinned[day, default: false].toggle()
    }
}

