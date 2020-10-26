import UIKit
import JTAppleCalendar
import Anchorage

struct CalendarCellViewModel {

    let text: String?

    let textColor: UIColor?

    let backgroundColor: UIColor?

}

class CalendarViewCell: JTACDayCell {
    //class CalendarViewCell: JTAppleCell {

    private var numberLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupSubviews()
        setupConstraints()
    }

}

extension CalendarViewCell {

    func configure(for viewModel: CalendarCellViewModel?) {
        guard let viewModel = viewModel else { return }

        backgroundColor = viewModel.backgroundColor

        numberLabel.text = viewModel.text ?? "-1"
        numberLabel.textColor = viewModel.textColor ?? .purple
    }

}

private extension CalendarViewCell {

    func setupSubviews() {
        numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = .preferredFont(forTextStyle: .body)
        numberLabel.textAlignment = .center
        numberLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        numberLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(numberLabel)
    }

    func setupConstraints() {
        numberLabel.edgeAnchors == contentView.edgeAnchors
    }

}
