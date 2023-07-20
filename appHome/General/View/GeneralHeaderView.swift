//
//  GeneralHeaderView.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import UIKit

class GeneralHeaderView: UIView {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var firstButtonLine: UIView!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var secondButtonLine: UIView!
    
    private var firstButtonTapped: (() -> Void)?
    private var secondButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        guard let headerView = Bundle.main.loadNibNamed("GeneralHeaderView", owner: self, options: nil)?[0] as? UIView else { return }
        headerView.frame = bounds
        addSubview(headerView)
    }
    
    public func setupView(title: String, firstSegmentTitle: String, secondSegmentTitle: String, firstSegmentTap: @escaping () -> Void, secondSegmentTap: @escaping () -> Void) {
        headerTitle.text = title
        firstButton.setTitle(firstSegmentTitle, for: .normal)
        secondButton.setTitle(secondSegmentTitle, for: .normal)
        self.firstButtonTapped = firstSegmentTap
        self.secondButtonTapped = secondSegmentTap
        secondButtonLine.isHidden = true
    }
    
    @IBAction func tappedFirstButton(_ sender: Any) {
        firstButtonLine.isHidden = false
        secondButtonLine.isHidden = true
        firstButtonTapped?()
    }
    
    
    @IBAction func tappedSecondButton(_ sender: Any) {
        firstButtonLine.isHidden = true
        secondButtonLine.isHidden = false
        secondButtonTapped?()
    }
}
