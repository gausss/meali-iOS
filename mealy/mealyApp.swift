import SwiftUI

@main
struct mealyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear(perform: MigrationService().migrate)
        }
    }
}
