import Foundation
import ObjectMapper

struct AnalyzeResponse : Mappable {

    var uri: String?
    var yield: Int?
    var calories: Double?
    var totalWeight: Double?
    var dietLabels: [String]?
    var healthLabels: [String]?
    var cautions : [String]?
    var totalNutrients : TotalNutrients?
    var totalDaily : TotalNutrients?
    var totalNutrientsKCal : TotalNutrientsKCal?
    var ingredient: [Ingredient]?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        uri <- map["uri"]
        yield <- map["yield"]
        calories <- map["calories"]
        totalWeight <- map["totalWeight"]
        dietLabels <- map["dietLabels"]
        healthLabels <- map["healthLabels"]
        totalNutrients <- map["totalNutrients"]
        totalDaily <- map["totalDaily"]
        ingredient <- map["ingredients"]
    }

}
