import UIKit

class AppCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let window : UIWindow?
   
    init(window: UIWindow? , navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let myCoordinator = MainCoordinator(navigationController: navigationController)
        addCoordinator(coordinator: myCoordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        myCoordinator.start()
    }
}
