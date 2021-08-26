import UIKit

protocol Coordinator : AnyObject {
    
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    func start()
    
}

extension Coordinator {
    
    func addCoordinator(coordinator : Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeCoordinator(coordinator : Coordinator) {
        childCoordinators =  childCoordinators.filter({$0 !== coordinator})
    }
}
