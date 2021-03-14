//
//  DashboardViewController.swift
//  Meditations
//
//  Created by Emrah Akgül on 13.03.2021.
//

import UIKit
import class Meditations_UI.CardCollectionViewCell

protocol DashboardViewInterface: BaseViewInterface, CollectionViewInterface {
    func prepareBannerView()
    func handleBannerView()
}

private extension DashboardViewController {
    enum MeditationsCollectionViewConstants {
        static let minimumLineSpacing: CGFloat = 16.0
        static let leftInset: CGFloat = 24.0
        static let rightInset: CGFloat = 24.0
        static let width: CGFloat = 156.0
        static let height: CGFloat = 280.0
    }
    
    enum StoriesCollectionViewConstants {
        static let minimumLineSpacing: CGFloat = 16.0
        static let topInset: CGFloat = 16.0
        static let leftInset: CGFloat = 24.0
        static let rightInset: CGFloat = 24.0
        static let width: CGFloat = 156.0
        static let height: CGFloat = 280.0
    }
    
    enum Constants {
        static let bannerViewLayer: CGFloat = 8.0
        static let numberPerLine: CGFloat = 2.0
    }
}

final class DashboardViewController: UIViewController {
    @IBOutlet private weak var meditationsCollectionView: UICollectionView!
    @IBOutlet private weak var bannerContainerView: UIView!
    @IBOutlet private weak var bannerView: UIView!
    @IBOutlet private weak var storiesCollectionView: UICollectionView!
    
    @IBOutlet private weak var storiesCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var meditationsTitleLabel: UILabel!
    @IBOutlet private weak var storiesTitleLabel: UILabel!
    
    var presenter: DashboardViewPresenterInterface!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var storiesCollectionViewItemWidth: CGFloat {
        let margins = (StoriesCollectionViewConstants.leftInset + StoriesCollectionViewConstants.rightInset + StoriesCollectionViewConstants.minimumLineSpacing)
        return (UIScreen.main.bounds.size.width - margins) / Constants.numberPerLine
    }
    
    private lazy var meditationsCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = MeditationsCollectionViewConstants.minimumLineSpacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: MeditationsCollectionViewConstants.leftInset, bottom: .zero, right: MeditationsCollectionViewConstants.rightInset)
        layout.itemSize = CGSize(width: MeditationsCollectionViewConstants.width, height: MeditationsCollectionViewConstants.height)
        return layout
    }()
    
    private lazy var storiesCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = StoriesCollectionViewConstants.minimumLineSpacing
        layout.minimumLineSpacing = .zero
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: StoriesCollectionViewConstants.topInset, left: StoriesCollectionViewConstants.leftInset, bottom: .zero, right: StoriesCollectionViewConstants.rightInset)
        layout.itemSize = CGSize(width: storiesCollectionViewItemWidth, height: StoriesCollectionViewConstants.height)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        storiesCollectionViewHeight.constant = storiesCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

}

extension DashboardViewController: DashboardViewInterface {
    func prepareNavigationBar() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIColor.black.as1ptImage()
    }
    
    func prepareBannerView() {
        bannerView.layer.cornerRadius = Constants.bannerViewLayer
        bannerView.clipsToBounds = true
    }
    
    func handleBannerView() {
        bannerContainerView.isHidden = !presenter.shouldShowBannerView()
    }
    
    func preparePageTitle() {
        self.navigationItem.title = ""
    }
    
    func reloadCollectionView() {
        meditationsCollectionView.reloadData()
        storiesCollectionView.reloadData()
        viewDidLayoutSubviews()
    }
    
    func prepareCollectionView() {
        meditationsTitleLabel.text = "Meditations"
        meditationsCollectionView.dataSource = self
        meditationsCollectionView.delegate = self
        meditationsCollectionView.showsHorizontalScrollIndicator = false
        meditationsCollectionView.tag = CollectionViewTag.meditations.rawValue
        meditationsCollectionView.collectionViewLayout = meditationsCollectionViewLayout
        
        
        storiesTitleLabel.text = "Stories"
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        storiesCollectionView.showsVerticalScrollIndicator = false
        storiesCollectionView.tag = CollectionViewTag.stories.rawValue
        storiesCollectionView.collectionViewLayout = storiesCollectionViewLayout
        storiesCollectionView.allowsMultipleSelection = false
        
        meditationsCollectionView.register(cellType: CardCollectionViewCell.self)
        storiesCollectionView.register(cellType: CardCollectionViewCell.self)
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.tag = collectionView.tag
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.tag = collectionView.tag
        
        let cell = collectionView.dequeueReusableCell(with: CardCollectionViewCell.self, for: indexPath)
        cell.setupUI(presentation: presenter.cellPresentation(index: indexPath.row))
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.tag = collectionView.tag
        collectionView.deselectItem(at: indexPath, animated: false)
        presenter.selectItem(index: indexPath.row)
    }
}
