
import Foundation
import Swinject
import SwinjectStoryboard
extension AppDelegate {
    /**
     Set up the depedency graph in the DI container
     */
     func setupDependencies() {
     
        // register services
        container.register(NutritionNetworkProtocal.self) { _ in NutritionNetworkManager()  }.inObjectScope(.container)
       
         
        // viewmodels
        container.register(HomeViewModel.self) { _ in HomeViewModel()  }.inObjectScope(.container)

         
        container.register(BaseViewModel.self ,name:"IngredientsDetailsViewModel") { r in IngredientsDetailsViewModel(networkInstance: r.resolve(NutritionNetworkProtocal.self)!)  }.inObjectScope(.container)
        
        container.register(BaseViewModel.self,name:"TotalFactsViewModel") { r in TotalFactsViewModel(networkInstance: r.resolve(NutritionNetworkProtocal.self)!)  }.inObjectScope(.container)

    }
}
