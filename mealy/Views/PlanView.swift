import SwiftUI

struct PlanView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(1...4, id: \.self) { i in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(i)")
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .padding()
                                    .overlay(
                                        Circle()
                                            .stroke(Color.accentColor, lineWidth: 4)
                                            .padding(6)
                                    )
                                Text("Gericht").font(.title)
                            }
                            Text("Zutaten")
                        }
                    }
                }.listStyle(.inset).navigationTitle("Dein Plan")
                
                Button(action: generate) {
                    Label("Plan erstellen", systemImage: "list.bullet.rectangle")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule).padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            }
        }
    }
    
    private func generate() {

    }

}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView().preferredColorScheme(.dark)
    }
}
