//
//  ViewController.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit

class ViewController: GeneralViewController {
    
    
    @IBOutlet weak var instansesTableView: ObjectTableView!
    @IBOutlet weak var headerView: GeneralHeaderView!
    
    private let networkManager = NetworkService()
    private var cameras: Array<ObjectImplementation> = []
    private var doors: Array<ObjectImplementation> = []
    private var isCameraShow: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTableView()
    }
    
    private func setupHeader() {
        headerView.layer.shadowOpacity = 0.6
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowRadius = 2
        navigationController?.navigationBar.isHidden = true
        headerView.setupView(title: "Мой дом", firstSegmentTitle: "Камеры", secondSegmentTitle: "Двери") { [weak self] in
            guard let isCameraShow = self?.isCameraShow else { return }
            if !isCameraShow {
                self?.isCameraShow = !isCameraShow
                Camera.readItems(refresh: false) { instList in
                    guard let instList = instList as? [ObjectRealization] else { return }
                    self?.instansesTableView.setupItems(instList)
                }
            }
        } secondSegmentTap: { [weak self] in
            guard let isCameraShow = self?.isCameraShow else { return }
            if isCameraShow {
                self?.isCameraShow = !isCameraShow
                Door.readItems(refresh: false) { instList in
                    guard let instList = instList as? [ObjectRealization] else { return }
                    self?.instansesTableView.setupItems(instList)
                }
            }
        }
    }
    
    private func setupTableView() {
        Camera.readItems(refresh: false) { [weak self] instList in
            self?.instansesTableView.setupItems(instList)
        }
        instansesTableView.setup(isCameraShow, { [weak self] in
            guard let isCameraShow = self?.isCameraShow else { return }
            switch isCameraShow {
            case true:
                Camera.readItems(refresh: true) { instList in
                    guard let instList = instList as? [ObjectRealization] else { return }
                    self?.instansesTableView.setupItems(instList)
                }
            case false:
                Door.readItems(refresh: true) { instList in
                    guard let instList = instList as? [ObjectRealization] else { return }
                    self?.instansesTableView.setupItems(instList)
                }
            }
        }, { [weak self] instance in
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailVC = storyboard.instantiateViewController(withIdentifier: storyboardID.detailViewController.rawValue) as? DetailViewController else { return }
            guard let isCameraShow = self?.isCameraShow else { return }
            detailVC.setupItem(instance, isDoor: !isCameraShow)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }, { [weak self] alert in
            self?.present(alert, animated: false, completion: nil)
        })
    }
}

