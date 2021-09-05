import Foundation

enum NetworkConstant {
    static var generalAppHeaders : [String : String] {
        return [
            "Accept" : "application/json"]
    }
    static var baseUrl = "https://api.edamam.com/api/"

    enum ApiKey {
        static let appID = "47379841"
        static let appKey = "d28718060b8adfd39783ead254df7f92"
    }
}
