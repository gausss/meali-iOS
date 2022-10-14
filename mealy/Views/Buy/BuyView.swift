import SwiftUI

struct BuyView : View {
    @ObservedObject var mealService: MealService
    @ObservedObject var planService: PlanService
    
    var body: some View {
        NavigationView {
            VStack {
                if(planService.plan.isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Selina, es gibt nichts zu kaufen ohne Essensplan.").font(.title2)
                        
                        Image("Penne").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }
                
                List {
                    ForEach(planService.getIngredients(plan: planService.plan, meals: mealService.meals), id: \.self) { buyItem in Text(buyItem)
                    }
                }.listStyle(.plain)
                
                Button(action: copy) {
                    Label("Kopieren", systemImage: "doc.on.doc")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule)
            }.navigationTitle("Einkaufsliste")
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
        }
    }
    
    private func copy() {
        UIPasteboard.general.string = planService.getIngredients(plan: planService.plan, meals: mealService.meals).joined(separator: "\n")
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView(mealService: MealService(), planService: PlanService()).preferredColorScheme(.dark)
    }
}
