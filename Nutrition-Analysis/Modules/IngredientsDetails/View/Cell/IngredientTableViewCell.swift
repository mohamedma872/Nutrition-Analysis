import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    var viewModel: IngredientCellViewModel? {
        didSet {
            bindViewmodel()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindViewmodel() {
        quantityLabel.text = viewModel?.quantity
        unitLabel.text = viewModel?.unit
        foodLabel.text =  viewModel?.foodName
        weightLabel.text = viewModel?.weight
    }

}
