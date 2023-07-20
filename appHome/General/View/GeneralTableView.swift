//
//  GeneralTableView.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit

class GeneralTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    struct CellData {
        var id: String
        var data: Any?
        var cellTapped: (() -> Void)?
        var height: CGFloat?
    }
    
    var cells = [GeneralTableView.CellData]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        start()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        start()
    }
    
    func start() {
        delegate = self
        dataSource = self
        setup()
    }
    
    func setup() {}
    
    func setupItems(_ items: [Any]) {}
    
    func setupTrailingContext(indexPath: IndexPath) -> UISwipeActionsConfiguration? { return nil }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = cells[indexPath.row]
        let cell = dequeueReusableCell(withIdentifier: item.id) as! GeneralTableViewCell
        cell.setup(data: item.data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = cells[indexPath.row]
        item.cellTapped?()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cells[indexPath.row].height {
            return height
        } else {
            return .leastNormalMagnitude
        }
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return setupTrailingContext(indexPath: indexPath)
    }
}
