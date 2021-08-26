import UIKit
import RxSwift
import RxCocoa

class IngredientsDetailsViewController: UIViewController , Storyboarded {

    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var ingredientsContainerView: UIView!
    @IBOutlet weak var showTotalFactsBtn: UIButton!
    weak var coordinator: MainCoordinator?
    let ingredientsTableViewCell = "IngredientTableViewCell"
    var viewModel : IngredientsDetailsViewModel?
    let disposeBag = DisposeBag()
    var ingredients: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    func setupTableView() {
        ingredientsTableView.register(UINib(nibName: ingredientsTableViewCell, bundle: nil), forCellReuseIdentifier: ingredientsTableViewCell)
    }
   
    func bindViewModel() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel
            .onShowError
            .subscribe(onNext: { [weak self] in
                self?.alert(title: "error", message: $0)
            }).disposed(by: disposeBag)
        
        viewmodel
            .onShowLoading
            .map { [weak self] in
                if $0 {
                self?.showIndicator()
            } else {
                self?.hideIndicator()
            } }
            .subscribe()
            .disposed(by: disposeBag)
        subscribeToResponse()
        getIngredients()
        subscribeToTotalFactsBtn()
    }
    func subscribeToResponse() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel.CellsObservable.bind(to: self.ingredientsTableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .normal(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as? IngredientTableViewCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel
                return cell
                
            case .error(let message):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = message
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "noDataAvailable"
                return cell
            }
        }.disposed(by: disposeBag)
       
    }
    func getIngredients() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel.AnalyzeAllIngr(ingr: ingredients ?? [] )
    }
    func subscribeToTotalFactsBtn() {
        showTotalFactsBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.coordinator?.NavigateToTotalNutritionFacts(ingredients: self.ingredients)
        }).disposed(by: disposeBag)
        
    }

}
