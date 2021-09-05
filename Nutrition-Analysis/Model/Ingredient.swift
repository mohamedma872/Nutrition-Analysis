import Foundation
import ObjectMapper

struct Ingredient : Mappable {
    
    var text: String?
    var parsed: [Parsed]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        text <- map["text"]
        parsed <- map["parsed"]
}
}

struct Parsed : Mappable {
    
    var quantity: Int?
    var measure, foodMatch, food, foodID: String?
    var weight, retainedWeight: Double? ,nutrient: Nutrient?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        quantity <- map["quantity"]
        measure <- map["measure"]
        foodMatch <- map["foodMatch"]
        food <- map["food"]
        foodID <- map["foodID"]
        weight <- map["weight"]
        retainedWeight <- map["retainedWeight"]
        nutrient <- map["nutrients"]
    }
    
}
