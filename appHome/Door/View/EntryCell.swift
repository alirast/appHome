//
//  EntryCell.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit

class EntryCell: GeneralTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func setup(data: Any?) {
        guard let door = data as? Door else { return }
        titleLabel.text = door.name
    }
}
