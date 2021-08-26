import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
  
    let disposeBag = DisposeBag()
    var ingredientsTextViewBehavior = BehaviorRelay<String>(value : "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var IngredientsSubject = PublishSubject<[String]>()
    var IngredientsSubjectObservable: Observable<[String]> {
        return IngredientsSubject
    }
    init() {
       
    }
    var ingredientsTextViewValid : Observable<Bool> {
        ingredientsTextViewBehavior.asObservable().map { ingredientsText -> Bool in
            return ingredientsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    var isAnalyzeButtonEnapled: Observable<Bool> {
        ingredientsTextViewBehavior.asObservable().map { ingredientsText -> Bool in
            return !ingredientsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && ingredientsText != "For example:\n1 cup rice\n"
        }
    }
    
    func getIngredients() {

            let ingredients =  ingredientsTextViewBehavior.value.split(separator: "\n").compactMap({String($0)})
            self.IngredientsSubject.onNext(ingredients)
        }
  
}
