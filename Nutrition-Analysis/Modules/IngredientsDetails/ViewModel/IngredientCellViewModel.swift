import Foundation
struct IngredientCellViewModel {
    var quantity: String?
    var unit: String?
    var foodName: String?
    var weight: String?
    init(model : Parsed?) {
        self.quantity = "\(model?.quantity ?? 0)"
        self.unit = model?.measure ?? "-"
        self.foodName = model?.foodMatch ?? "-"
        self.weight = "\(model?.weight ?? 0) g"
        
    }
}
