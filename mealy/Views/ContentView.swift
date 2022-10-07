import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlanView()
                .tabItem {
                                Label("Planen", systemImage:"list.bullet.clipboard")
                            }
            MealList()
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
