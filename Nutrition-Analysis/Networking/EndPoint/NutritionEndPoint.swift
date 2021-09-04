import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum NutritionApi {
    case analyze( ingr: String)
    case getFacts( ingr: [String])
}

extension NutritionApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NutritionNetworkManager.environment {
        case .production: return NetworkConstant.baseUrl
        case .qa: return NetworkConstant.baseUrl + "qaServer"
        case .staging: return NetworkConstant.baseUrl + "StagingServer"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .analyze:
            return "nutrition-data"
        case .getFacts:
            return "nutrition-details"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .analyze:
            return .get
        case .getFacts:
            return .post
        }
       
    }
    var task: HTTPTask {
        var params = [String:String]()
        let headers = [ "Content-Type": "application/json" ]
        switch self {
        case .analyze(let ingredientsEncoded):
            params = ["app_id" : NetworkConstant.ApiKey.appID,
                      "app_key": NetworkConstant.ApiKey.appKey, "ingr": ingredientsEncoded]
        case .getFacts:
            params = ["app_id" : NetworkConstant.ApiKey.appID,
                      "app_key": NetworkConstant.ApiKey.appKey]
        }
        switch self {
        case .analyze:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: headers)
        case .getFacts(let ingredients):
           
            return .requestParametersAndHeaders(bodyParameters: ["ingr" : ingredients], bodyEncoding: .urlAndJsonEncoding, urlParameters: params, additionHeaders: headers )
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
