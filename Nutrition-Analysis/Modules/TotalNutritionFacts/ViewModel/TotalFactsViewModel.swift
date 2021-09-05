import Foundation
import RxSwift
import RxCocoa

class TotalFactsViewModel : BaseViewModel {
   
    let disposeBag = DisposeBag()
    private let networkInstance: NutritionNetworkProtocal
    init(networkInstance : NutritionNetworkProtocal = NutritionNetworkManager()) {
        self.networkInstance = networkInstance
    }
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var onShowLoading: Observable<Bool> {
            return loadingBehavior
                .asObservable()
                .distinctUntilChanged()
        }
    private var AnalyzeResponseSubject = PublishSubject<AnalyzeResponse>()
    var AnalyzeResponseObservable: Observable<AnalyzeResponse> {
        return AnalyzeResponseSubject
    }
    let onShowError = PublishSubject<String>()
    func getFacts(ingr: [String]) {
        loadingBehavior.accept(true)
        networkInstance.getFacts(ingr: ingr).subscribe(
                    onNext: { [weak self] res in
                        self?.loadingBehavior.accept(false)
                        if let data = res {
                            self?.AnalyzeResponseSubject.onNext(data)
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
