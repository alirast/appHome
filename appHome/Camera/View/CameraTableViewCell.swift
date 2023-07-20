//
//  CameraTableViewCell.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit
import Kingfisher

class CameraTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var cameraTitle: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!

    override func setup(data: Any?) {
        guard let camera = data as? Camera else { return }
        if !camera.favorites {
            favoriteImage.isHidden = true
        }
        cameraTitle.text = camera.name
        if let snapshot = camera.snapshot {
            let url = URL(string: snapshot)
            cameraImage.kf.setImage(with: url)
        }
    } 
}
