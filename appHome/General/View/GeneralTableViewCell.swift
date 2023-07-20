//
//  GeneralTableViewCell.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {
    
    var cellItem: GeneralTableView.CellData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        start()
    }
    
    func start() {
        
    }
    
    func setup(data: Any?) {
        
    }
    
    func getCellData() -> Any? {
        return cellItem?.data
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
