import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var analyseBtn: UIButton!
    weak var coordinator: MainCoordinator?
    var viewModel : HomeViewModel?
    let disposeBag = DisposeBag()
    let ingredientTextViewPlaceholder = "For example:\n1 cup rice\n"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
        setupUI()
    }
    func bindViewModel() {
        bindTextViewToViewModel()
        subscribeIsAnalyseBtnEnabled()
        subscribeToAnalyseBtn()
        
    }
    func  bindTextViewToViewModel() {
        guard  let viewmodel = viewModel else {
            return
        }
        ingredientTextView.rx.text.orEmpty.bind(to: viewmodel.ingredientsTextViewBehavior).disposed(by: disposeBag)
    }

    func subscribeIsAnalyseBtnEnabled() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel.isAnalyzeButtonEnapled.bind(to: analyseBtn.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToAnalyseBtn() {
        guard  let viewmodel = viewModel else {
            return
        }
        analyseBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                viewmodel.getIngredients()
        }).disposed(by: disposeBag)
        viewmodel.IngredientsSubjectObservable.subscribe(onNext: {[weak self] in
            if !$0.isEmpty {
                self?.coordinator?.NavigateToIngredientsDetails(ingredients: $0)
            }}).disposed(by: disposeBag)
    }

}
extension HomeViewController {
    
    private func setupUI() {
        ingredientTextView.sizeToFit()
        ingredientTextView.isScrollEnabled = false
        setPlaceholderTorecipeTextView(placeholder: ingredientTextViewPlaceholder)
        ingredientTextViewActions(placeholder: ingredientTextViewPlaceholder)
    }
 
    private func ingredientTextViewActions(placeholder: String) {
        ingredientTextView.rx.didBeginEditing.bind { (_) in
            if self.ingredientTextView.textColor == UIColor.lightGray {
                self.ingredientTextView.text = ""
                self.ingredientTextView.textColor = UIColor.black
            }
        }.disposed(by: disposeBag)
        
        ingredientTextView.rx.didEndEditing.bind { (_) in
            self.setPlaceholderTorecipeTextView(placeholder: placeholder)
        }.disposed(by: disposeBag)
        
        ingredientTextView.rx.didChange.bind { (_) in
            
        }.disposed(by: disposeBag)
    }
    
    private func setPlaceholderTorecipeTextView(placeholder: String) {
        if self.ingredientTextView.text.isEmpty {
            self.ingredientTextView.text = placeholder
            self.ingredientTextView.textColor = UIColor.lightGray
        }
    }
}
