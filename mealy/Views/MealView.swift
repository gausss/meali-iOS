import SwiftUI

struct MealView: View {
    @State private var editMode = EditMode.inactive
    @State var isArticleDetailsViewPresented: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(meals) { meal in
                    NavigationLink {
                        MealDetail(meal: meal)
                    } label: {
                        Text(meal.name)
                    }
                }.onDelete(perform: onDelete)
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationTitle("Gerichte")
            .environment(\.editMode, $editMode)
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    func onAdd() {
        // To be implemented in the next section
    }
    
    func onDelete(offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
    }
    
    func onMove(source: IndexSet, destination: Int) {
        meals.move(fromOffsets: source, toOffset: destination)
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView().preferredColorScheme(.dark)
    }
}
