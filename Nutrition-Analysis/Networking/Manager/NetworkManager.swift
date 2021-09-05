import Foundation
import ObjectMapper
import RxSwift
enum NetworkResponse:String,Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}
protocol BaseNetworkManager{
    static var environment: NetworkEnvironment { get }
    var router: NetworkRouter {get set}
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}
extension BaseNetworkManager{
    // default implementation for handleNetworkResponse function
     func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
// Implementing SOLID - Interface Segregation
protocol NutritionNetworkProtocal : BaseNetworkManager {
    func analyze(ingr: String) -> Observable<AnalyzeResponse?>
    func getFacts(ingr: [String]) -> Observable<AnalyzeResponse?>
    
}
struct NutritionNetworkManager : NutritionNetworkProtocal{
    var router : NetworkRouter = Router<NutritionApi>()
    static let environment : NetworkEnvironment = .production
    func analyze(ingr: String) -> Observable<AnalyzeResponse?> {
        return Observable.create { observer -> Disposable in
            router.request(NutritionApi.analyze(ingr: ingr)) { data, response, error in

                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            observer.onError(NetworkResponse.noData)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            
                            let apiResponse = Mapper<AnalyzeResponse>().map(JSON: jsonData as! [String:Any])
                           
                            observer.onNext(apiResponse)
                        } catch {
                            print(error)
                          
                            observer.onError(NetworkResponse.unableToDecode)
                        }
                    case .failure(_):
                     
                        observer.onError(NetworkResponse.failed)
                    }
                }
            }
            return Disposables.create()
        }
    }
    func getFacts(ingr: [String]) -> Observable<AnalyzeResponse?> {
        return Observable.create { observer -> Disposable in
            router.request(NutritionApi.getFacts(ingr: ingr)) { data, response, error in

                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            observer.onError(NetworkResponse.noData)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            
                            let apiResponse = Mapper<AnalyzeResponse>().map(JSON: jsonData as! [String:Any])
                           
                            observer.onNext(apiResponse)
                        } catch {
                            print(error)
                            observer.onError(NetworkResponse.unableToDecode)
                        }
                    case .failure(_):
                     
                        observer.onError(NetworkResponse.failed)
                    }
                }
            }
            return Disposables.create()
        }
    }


}
