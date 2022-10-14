import SwiftUI

struct BuyView : View {
    @ObservedObject var mealService: MealService
    @ObservedObject var planService: PlanService
    
    var body: some View {
        NavigationView {
            VStack {
                if(planService.plan.isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Es gibt nichts zu kaufen.").font(.title2)
                        Image("Penne").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }
                
                List {
                    ForEach(getIngredient(), id: \.self) {
                        buyItem in Text(buyItem)
                    }
                }.listStyle(.plain)
                
                Button(action: copy) {
                    Label("Kopieren", systemImage: "clipboard")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule).disabled(planService.plan.isEmpty)
            }
            .navigationTitle("Einkaufsliste")
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
        }
    }
    
    private func copy() {
        UIPasteboard.general.string = getIngredient().joined(separator: "\n")
    }
    
    private func getIngredient() -> [String] {
        planService.getIngredients(plan: planService.plan, meals: mealService.meals)
    }
}
