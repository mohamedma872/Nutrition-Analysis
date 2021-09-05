import UIKit
import Swinject
class MainCoordinator: Coordinator , MainCoordinatorProctocol {
    let container: Container
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController,container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        let homeViewmodel = HomeViewModel()
        vc.coordinator = self
        vc.viewModel = homeViewmodel
        navigationController.pushViewController(vc, animated: false)
    }
  
    func NavigateToIngredientsDetails(ingredients: [String]?) {
        let vc = IngredientsDetailsViewController.instantiate()
        let viewmodel = container.resolve(BaseViewModel.self ,name:"IngredientsDetailsViewModel")! as! IngredientsDetailsViewModel
        vc.coordinator = self
        vc.ingredients = ingredients
        vc.viewModel = viewmodel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func NavigateToTotalNutritionFacts(ingredients: [String]?) {
        let vc = TotalFactsViewController.instantiate()
        let viewmodel = container.resolve(BaseViewModel.self,name:"TotalFactsViewModel")! as! TotalFactsViewModel
        vc.coordinator = self
        vc.ingredients = ingredients
        vc.viewModel = viewmodel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func didFinshed(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
