import SwiftUI

struct ContentView: View {
    @StateObject var mealService = MealService()
    @StateObject var planService = PlanService()

    var body: some View {
        TabView {
            PlanView(mealService: mealService, planService: planService)
                .tabItem {
                    Label("Planen", systemImage:"calendar")
                }
            MealList(mealService: mealService)
                    .tabItem {
                        Label("Gerichte", systemImage: "frying.pan")
                    }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
