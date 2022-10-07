import SwiftUI

struct PlanView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(meals) { meal in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(meal.id.formatted())
                                .frame(width: 15, height: 15, alignment: .center)
                                .padding()
                                .overlay(
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: 4)
                                    .padding(6)
                                )
                            Text(meal.name).font(.title)
                        }
                        Text(meal.ingredients.joined(separator: ","))
                    }
                }
            }.navigationTitle("Dein Plan").listStyle(.inset)
        }
    }
}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView().preferredColorScheme(.dark)
    }
}

