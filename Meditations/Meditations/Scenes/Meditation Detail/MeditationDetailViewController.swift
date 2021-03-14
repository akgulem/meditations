//
//  MeditationDetailViewController.swift
//  Meditations
//
//  Created by Emrah Akgül on 14.03.2021.
//

import UIKit

protocol MeditationDetailViewInterface: BaseViewInterface {
    func preparePageBody()
}

final class MeditationDetailViewController: UIViewController {
    
    @IBOutlet private weak var playContainerView: UIView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var presenter: MeditationDetailViewPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        playContainerView.layer.cornerRadius = 45
    }
}

extension MeditationDetailViewController: MeditationDetailViewInterface {
    func preparePageBody() {
        let presentation = presenter.getPresentation()
        titleLabel.text = presentation?.title
        detailLabel.text = presentation?.detail
        dateLabel.text = presentation?.date
    }
    
    func preparePageTitle() {
        navigationItem.title = ""
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIColor.black.as1ptImage()
        navigationController?.navigationBar.tintColor = .white
    }
}
