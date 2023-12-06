import Foundation

struct Ingredient: Codable, Hashable {
    let amount: String
    let unit: UnitType
    let name: String
    
    func print() -> String {
        return "\(self.amount)\(self.unit.rawValue) \(self.name)";
    }
}

