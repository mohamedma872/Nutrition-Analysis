import Foundation
import RxSwift
import RxCocoa

enum IngredientTableViewCellType {
    case normal(cellViewModel: IngredientCellViewModel)
    case error(message: String)
    case empty
}

class IngredientsDetailsViewModel : BaseViewModel {
    
    let disposeBag = DisposeBag()
    private let networkInstance: NetworkManager
    init(networkInstance : NetworkManager = NetworkManager()) {
        self.networkInstance = networkInstance
        CellsObservable = cells.asObservable()
    }
    private let loadingBehavior = BehaviorRelay<Bool>(value: false)
    var onShowLoading: Observable<Bool> {
            return loadingBehavior
                .asObservable()
                .distinctUntilChanged()
        }
  
   private let cells = BehaviorRelay<[IngredientTableViewCellType]>(value: [])
    var CellsObservable: Observable<[IngredientTableViewCellType]>

    let onShowError = PublishSubject<String>()
    func AnalyzeAllIngr(ingr: [String]) {
        loadingBehavior.accept(true)
        var array = [IngredientTableViewCellType]()
        let allObservables = ingr
            .map { networkInstance.analyze(ingr: $0) }
         Observable.merge(allObservables).subscribe(
            onNext: { [weak self] res in
                self?.loadingBehavior.accept(false)
                if let data = res {
                    array = self?.cells.value ?? []
                    array.append(contentsOf: data.ingredient?.compactMap { .normal(cellViewModel: IngredientCellViewModel(model: $0.parsed?.first )) } ?? [.empty])
                    self?.cells.accept(array)
                    
                }
            },
            onError: { [weak self] err in
                self?.loadingBehavior.accept(false)
                self?.onShowError.onNext(err.localizedDescription)
            }
        )
        .disposed(by: disposeBag)
     }
   
}
