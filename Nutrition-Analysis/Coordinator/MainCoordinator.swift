import UIKit
class MainCoordinator: Coordinator , MainCoordinatorProctocol {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        let viewmodel = IngredientsDetailsViewModel()
        vc.coordinator = self
        vc.ingredients = ingredients
        vc.viewModel = viewmodel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func NavigateToTotalNutritionFacts(ingredients: [String]?) {
        let vc = TotalFactsViewController.instantiate()
        let viewmodel = TotalFactsViewModel()
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
