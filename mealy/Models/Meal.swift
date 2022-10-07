import Foundation

struct Meal: Identifiable, Hashable, Codable {
 
    var id: Int
    var name: String
    var ingredients: [String]
    var description: String
    var created: Int
}
