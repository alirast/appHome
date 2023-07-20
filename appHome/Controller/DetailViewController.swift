//
//  DetailViewController.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit
import Kingfisher

class DetailViewController: GeneralViewController {
    
    @IBOutlet weak var instanceTitle: UILabel!
    @IBOutlet weak var instanceImageView: UIImageView!
    @IBOutlet weak var recView: UIView!
    @IBOutlet weak var openDoorView: UIView!
    @IBOutlet weak var zoomButton: UIButton!
    
    private var item: ObjectRealization?
    private var isDoorView: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInstanceImageView()
        setupOpenView()
        setupTitle()
    }
    
    public func setupItem(_ item: ObjectRealization, isDoor: Bool) {
        self.item = item
        self.isDoorView = isDoor
    }
    
    @IBAction func zoomCamera(_ sender: Any) {
        print("zoom")
    }
    
    private func setupInstanceImageView() {
        if let snapshot = item?.snapshot, snapshot != "" {
            let url = URL(string: snapshot)
            instanceImageView.kf.setImage(with: url)
        }
        
        if let isDoorView = isDoorView, isDoorView {
            zoomButton.isHidden = true
        }
    }
    
    private func setupTitle() {
        if let name = item?.name {
            instanceTitle.text = name
        }
    }
    
    private func setupOpenView() {
        if let isDoorView = isDoorView, isDoorView {
            openDoorView.isHidden = false
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openDoor(sender:)))
            openDoorView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func openDoor(sender: Any) {
        print("Opened the door")
    }
    
}
