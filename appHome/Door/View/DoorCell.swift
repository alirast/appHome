//
//  DoorCell.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit
import Kingfisher

class DoorCell: GeneralTableViewCell {

    @IBOutlet weak var doorImageView: UIImageView!
    @IBOutlet weak var doorTitle: UILabel!
    
    override func setup(data: Any?) {
        guard let door = data as? Door else { return }
        if let snapshot = door.snapshot {
            let url = URL(string: snapshot)
            doorImageView.kf.setImage(with: url)
        } else {
            doorImageView.isHidden = true
        }
        doorTitle.text = door.name
    }
}
