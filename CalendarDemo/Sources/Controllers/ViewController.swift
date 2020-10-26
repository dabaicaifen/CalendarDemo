import UIKit
import JTAppleCalendar
import Anchorage

class ViewController: UIViewController {

    private var calendarView: JTACMonthView!

    private var tableView: UITableView!

    private var stackView: UIStackView!

    private var selectedDate = Date()

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { preconditionFailure("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        calendarView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.reuseIdentifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        let model = DefaultTableViewCellViewModel(text: "\(selectedDate)", detail: nil)
        cell.configure(for: model)
        return cell
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController(detail: "\(selectedDate)")
        navigationController?.pushViewController(controller, animated: true)
    }

}

extension ViewController: JTACMonthViewDataSource {

    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = Date.set(day: 1, hour: 0, minute: 0, second: 0) ?? Date()
        let endDate = Date.set(day: 31, hour: 0, minute: 0, second: 0) ?? Date()

        let config = ConfigurationParameters(startDate: startDate,
                                             endDate: endDate,
                                             numberOfRows: 6,
                                             calendar: .current,
                                             generateInDates: .forAllMonths,
                                             generateOutDates: .tillEndOfGrid,
                                             firstDayOfWeek: .sunday,
                                             hasStrictBoundaries: nil)

        return config
    }

}

extension ViewController: JTACMonthViewDelegate {

    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let calendarCell = cell as? CalendarViewCell else { return }
        configure(cell: calendarCell, state: cellState, date: date, calendar: calendar)
    }


    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let calendarCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarViewCell.reuseIdentifier, for: indexPath) as? CalendarViewCell else { return JTACDayCell() }
        configure(cell: calendarCell, state: cellState, date: date, calendar: calendar)
        return calendarCell
    }

    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("select \(date)")
        selectedDate = date
        guard let calendarCell = cell as? CalendarViewCell else { return }
        configure(cell: calendarCell, state: cellState, date: date, calendar: calendar)
        tableView.reloadData()
    }

    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("de select \(date)")
        guard let calendarCell = cell as? CalendarViewCell else { return }
        configure(cell: calendarCell, state: cellState, date: date, calendar: calendar)
        tableView.reloadData()
    }

//    // version 7
//    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
//        print("select \(date)")
//        selectedDate = date
//        guard let calendarCell = cell as? CalendarViewCell else { return }
//        configure(cell: calendarCell, state: cellState, date: date, calendar: calendar)
//        tableView.reloadData()
//    }
//
//    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
//        print("de select \(date)")
//        guard let calendarCell = cell as? CalendarViewCell else { return }
//        configure(cell: calendarCell, state: cellState, date: date, calendar: calendar)
//        tableView.reloadData()
//    }

}

// MARK: - Private

private extension ViewController {

    func setupSubviews() {
        view.backgroundColor = .lightGray

        calendarView = JTACMonthView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .white
        calendarView.scrollDirection = .horizontal
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.isScrollEnabled = false
        calendarView.scrollingMode = .none
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.allowsMultipleSelection = false
        calendarView.allowsRangedSelection = false
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        calendarView.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.reuseIdentifier)

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.reuseIdentifier)

        stackView = UIStackView(arrangedSubviews: [calendarView, tableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20

        view.addSubview(stackView)
    }

    func setupConstraints() {
        stackView.edgeAnchors == view.edgeAnchors

        calendarView.heightAnchor == 600
        tableView.heightAnchor >= 50
    }

    func configure(cell: CalendarViewCell, state: CellState, date: Date, calendar: JTACMonthView) {
        let textColor: UIColor = .gray
        let backgroundColor: UIColor = state.isSelected ? .yellow : .white

        let model = CalendarCellViewModel(text: state.text,
                                          textColor: textColor,
                                          backgroundColor: backgroundColor)
        cell.configure(for: model)
    }

}

