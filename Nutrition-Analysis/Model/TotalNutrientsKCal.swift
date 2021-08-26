import Foundation
import ObjectMapper

struct TotalNutrientsKCal : Mappable {
	var eNERC_KCAL : Nutrient?
	var pROCNT_KCAL : Nutrient?
	var fAT_KCAL : Nutrient?
	var cHOCDF_KCAL : Nutrient?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		eNERC_KCAL <- map["ENERC_KCAL"]
		pROCNT_KCAL <- map["PROCNT_KCAL"]
		fAT_KCAL <- map["FAT_KCAL"]
		cHOCDF_KCAL <- map["CHOCDF_KCAL"]
	}

}
