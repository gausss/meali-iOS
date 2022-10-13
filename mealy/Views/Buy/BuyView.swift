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
                    ForEach(planService.getIngredientList(plan: planService.plan, meals: mealService.meals), id: \.self) { buyItem in
                        Text(buyItem)
                    }
                }.listStyle(.plain)
            }.navigationTitle("Einkaufsliste")
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView(mealService: MealService(), planService: PlanService()).preferredColorScheme(.dark)
    }
}
