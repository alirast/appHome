//
//  RubetekUITableView.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit

class ObjectTableView: GeneralTableView {
    
    enum CellHeight: CGFloat {
        case short = 100
        case tall = 300
    }
    
    enum CellName: String {
        case cameraCell = "CameraTableViewCell"
        case doorCell = "DoorTableViewCell"
        case smallDoorCell = "SmallDoorTableViewCell"
    }
    
    private var refreshAction: (() -> Void)?
    private var cellTapped: ((ObjectRealization) -> Void)?
    private var showAlert: ((UIAlertController) -> Void)?
    private var cameraVisible: Bool = true
    
    
    public func setup(_ cameraVisible: Bool, _ refreshAction: @escaping (() -> Void), _ cellTapped: @escaping ((ObjectRealization) -> Void), _ showAlert: @escaping (UIAlertController) -> Void) {
        self.cameraVisible = cameraVisible
        self.cellTapped = cellTapped
        self.showAlert = showAlert
        self.refreshAction = refreshAction
    }

    
    public func changeShowing(_ cameraVisible: Bool) {
        self.cameraVisible = cameraVisible
    }
    
    
    @objc func refreshTable(sender: Any) {
        refreshAction?()
    }
    
    
    override func setup() {
        register(UINib(nibName: CellName.cameraCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.cameraCell.rawValue)
        register(UINib(nibName: CellName.doorCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.doorCell.rawValue)
        register(UINib(nibName: CellName.smallDoorCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.smallDoorCell.rawValue)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable(sender:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    
    override func setupItems(_ items: [Any]) {
        var itemsList = [GeneralTableView.CellData]()
        for item in items {
            var height: CGFloat
            var id: String
            
            if let instance = item as? Door {
                if instance.snapshot == nil {
                    height = CellHeight.short.rawValue
                    id = CellName.smallDoorCell.rawValue
                } else {
                    height = CellHeight.tall.rawValue
                    id = CellName.doorCell.rawValue
                }
            } else {
                height = CellHeight.tall.rawValue
                id = CellName.cameraCell.rawValue
            }
            let cellTapped = { [weak self] in
                
                if let instance = item as? ObjectRealization {
                    self?.cellTapped?(instance)
                }
            }
            itemsList.append(GeneralTableView.CellData(id: id, data: item, cellTapped: cellTapped, height: height))
        }
        self.cells = itemsList
        reloadData()
        refreshControl?.endRefreshing()
    }
    
    
    override func setupTrailingContext(indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            let instance = self?.cells[indexPath.row].data as? ObjectRealization
            instance?.getFavourite()
        }
        favorite.image = UIImage(systemName: "star.fill")
        let changeName = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            let alert = UIAlertController(title: nil, message: "Сменить имя", preferredStyle: .alert)
            alert.addTextField { textfield in
                textfield.text = ""
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
                guard let textfield = alert?.textFields?[0] else { return }
                let instance = self?.cells[indexPath.row].data as? ObjectRealization
                guard let text = textfield.text else { return }
                instance?.changeName(text)
            }))
            self?.showAlert?(alert)
        }
        changeName.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [favorite, changeName])
    }
    
}
