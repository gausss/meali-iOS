import SwiftUI

struct PlanView: View {
    @ObservedObject var mealService: MealService
    @ObservedObject var planService: PlanService

    var body: some View {
        NavigationView {
            VStack {
                if(planService.plan.isEmpty) {
                    VStack(alignment: .leading) {
                        
                        Text("Selina, du hast noch keinen Plan erstellt. Solange gibt es Farfalle.").font(.title2)
                        
                        Image("Farfalle").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }
                
                List {
                    ForEach(planService.plan, id: \.day) { plan in
                        PlanRow(day: plan.day, meal: mealService.getByName(name: plan.mealName))
                    }
                }.listStyle(.plain)
                
                Button(action: generate) {
                    Label("Plan erstellen", systemImage: "list.bullet.rectangle")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule).padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            }.navigationTitle("Dein Plan")
        }
    }
    
    private func generate() {
        planService.clear()
        planService.regenerate(meals: mealService.meals, days: 4)
    }

}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(mealService: MealService(), planService: PlanService()).preferredColorScheme(.dark)
    }
}
