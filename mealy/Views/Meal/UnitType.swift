import Foundation

enum UnitType: String, Identifiable, Codable, Hashable {
    case g, ml, x
    var id: Self { self }
}
