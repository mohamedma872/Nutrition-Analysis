import Foundation
import ObjectMapper

struct TotalNutrients : Mappable {
	var eNERC_KCAL : Nutrient?
	var fAT : Nutrient?
	var fASAT : Nutrient?
	var fAMS : Nutrient?
	var fAPU : Nutrient?
	var cHOCDF : Nutrient?
	var pROCNT : Nutrient?
	var cHOLE : Nutrient?
	var nA : Nutrient?
	var cA : Nutrient?
	var mG : Nutrient?
	var k : Nutrient?
	var fE : Nutrient?
	var zN : Nutrient?
	var p : Nutrient?
	var vITC : Nutrient?
	var tHIA : Nutrient?
	var rIBF : Nutrient?
	var nIA : Nutrient?
	var vITB6A : Nutrient?
	var fOLDFE : Nutrient?
	var fOLFD : Nutrient?
	var fOLAC : Nutrient?
	var vITB12 : Nutrient?
	var vITD : Nutrient?
	var wATER : Nutrient?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		eNERC_KCAL <- map["ENERC_KCAL"]
		fAT <- map["FAT"]
		fASAT <- map["FASAT"]
		fAMS <- map["FAMS"]
		fAPU <- map["FAPU"]
		cHOCDF <- map["CHOCDF"]
		pROCNT <- map["PROCNT"]
		cHOLE <- map["CHOLE"]
		nA <- map["NA"]
		cA <- map["CA"]
		mG <- map["MG"]
		k <- map["K"]
		fE <- map["FE"]
		zN <- map["ZN"]
		p <- map["P"]
		vITC <- map["VITC"]
		tHIA <- map["THIA"]
		rIBF <- map["RIBF"]
		nIA <- map["NIA"]
		vITB6A <- map["VITB6A"]
		fOLDFE <- map["FOLDFE"]
		fOLFD <- map["FOLFD"]
		fOLAC <- map["FOLAC"]
		vITB12 <- map["VITB12"]
		vITD <- map["VITD"]
		wATER <- map["WATER"]
	}

}
