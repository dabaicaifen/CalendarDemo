import UIKit
import Anchorage

class DetailViewController: UIViewController {

    private var detailLabel: UILabel!

    private var detail: String?

    // MARK: - Initialization

    init(detail: String?) {
        self.detail = detail

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { preconditionFailure("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupConstraints()
    }

}

private extension DetailViewController {

    func setupSubviews() {
        view.backgroundColor = .white

        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = self.detail
        detailLabel.font = .preferredFont(forTextStyle: .body)
        detailLabel.textAlignment = .center

        view.addSubview(detailLabel)
    }

    func setupConstraints() {
        detailLabel.centerAnchors == view.centerAnchors
    }

}
