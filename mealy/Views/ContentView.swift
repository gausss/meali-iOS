import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedResults(MealLog.self) var mealLogs

    var body: some View {
        if let mealLog = mealLogs.first {
            TabView {
                PlanView(mealLog: mealLog)
                                .tabItem {
                                    Label("Planen", systemImage:"list.bullet.clipboard")
                                }
                
                MealView(mealLog: mealLog)
                    .tabItem {
                        Label("Gerichte", systemImage: "frying.pan")
                    }
            }
        } else {
            ProgressView().onAppear {
                $mealLogs.append(MealLog.mealLog1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
