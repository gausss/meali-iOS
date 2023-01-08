import SwiftUI

struct PlanView: View {
    @ObservedObject var mealService: MealService
    @ObservedObject var planService: PlanService
    @State var pinned: [Int: Bool] = [:]

    var body: some View {
        NavigationView {
            VStack {
                if(planService.plan.isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Du hast noch keinen Plan erstellt.").font(.title2)
                        Image("Farfalle").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }

                List {
                    ForEach(planService.plan, id: \.day) { suggestion in
                        PlanRow(day: suggestion.day, meal: mealService.getByID(ID: suggestion.mealID), pinned: $pinned)
                    }
                }.listStyle(.plain)

                Button(action: generate) {
                    Label("Erstellen", systemImage: "goforward")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule)
            }
            .navigationTitle("Dein Plan")
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
        }
    }

    private func generate() {
        planService.regenerate(meals: mealService.meals, pinned: pinned)
    }
}
