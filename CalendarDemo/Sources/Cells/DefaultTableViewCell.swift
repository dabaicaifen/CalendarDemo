import UIKit

struct DefaultTableViewCellViewModel {

    let text: String?

    let detail: String?

}

final class DefaultTableViewCell: UITableViewCell {

    // MARK: - Initializers

    init() {
        super.init(style: .default, reuseIdentifier: "DefaultTableViewCell")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "DefaultTableViewCell")
    }

    required init?(coder aDecoder: NSCoder) { preconditionFailure() }

}

// MARK: - ViewModelConfigurable Conformance

extension DefaultTableViewCell {

    func configure(for viewModel: DefaultTableViewCellViewModel?) {
        guard let viewModel = viewModel else { return }

        textLabel?.text = viewModel.text
        textLabel?.tintColor = UIColor.black

        detailTextLabel?.text = viewModel.detail
        detailTextLabel?.tintColor = UIColor.gray
    }

}
