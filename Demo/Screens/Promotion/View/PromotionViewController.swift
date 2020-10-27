
//
//  PromotionViewController.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

protocol PromotionViewControllerDelegate {
    func viewAllTapped()
    func promotionItemTapped(itemModel: PromotionItemModel?)
}

class PromotionViewController: UKBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
//    @IBOutlet weak var viewAllButton: STRoundedButton!
    
//    @IBOutlet weak var offerInfoView: STBaseView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Variables
    var delegate: PromotionViewControllerDelegate?
//    var theme = STBaseTheme()
    var viewModel: PromotionViewModel!
    var TVTimer: Timer?
    lazy var cellSize: CGSize = {
        let itemWidth = collectionView.frame.width
               let itemHeight: CGFloat = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }()
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //self.navigationItems = []
        self.viewModel  = PromotionViewModel()
    }
    
    // MARK: - Overrided Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.offerInfoView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.offerInfoView.addGestureRecognizer(swipeLeft)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        self.TVTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animateTVWidget), userInfo: nil, repeats: true)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cellSize.width  = collectionView.frame.width
        cellSize.height = collectionView.frame.height
        collectionView.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopanimateTVWidget()
    }
    func stopanimateTVWidget(){
        self.TVTimer?.invalidate()
        TVTimer = nil
    }
//    override func configureAppTheme(isLight: Bool? = true) {
//
//        super.configureAppTheme(isLight: isLight!)
//        self.view.backgroundColor = theme.bgPageColor
//        lblTitle.textColor        = theme.textColor
//        offerInfoView.borderColor = theme.bgPageColor1 ?? UIColor.orangePrimaryColor
//    }
    
    // MARK: - IBAction Methods
    @IBAction func viewAllButtonTapped(_ sender: Any) {
        delegate?.viewAllTapped()
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func setUpUI() {
        pageControl.currentPage = viewModel?.promotionModel.selectedIndex ?? 0
        let pages = viewModel?.promotionModel.itemList.count ?? 1
        pageControl.numberOfPages = pages
//        viewAllButton.makeRounded()
        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
    }
    
    fileprivate func updateUI(isShowAnimation: Bool? = true ) {
        pageControl.currentPage = viewModel.promotionModel.selectedIndex
        pageControl.setNeedsLayout()
        
        let targetIndexPath = IndexPath(row: viewModel.promotionModel.selectedIndex, section: 0)
        collectionView.scrollToItem(at: targetIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: isShowAnimation!)
    }
    
    @objc fileprivate func animateTVWidget(){
        
        let currentIndex = viewModel.promotionModel.selectedIndex
        let newIndex = currentIndex + 1
        if newIndex > viewModel.itemCountForSection() - 1 {
//            viewModel.promotionModel.selectedIndex = 0
//            updateUI(isShowAnimation: false)
            stopanimateTVWidget()
        } else{
            viewModel.promotionModel.selectedIndex = newIndex
            updateUI()
        }
    }
    
    @objc fileprivate func swipedRight(){
        stopanimateTVWidget()
        let newIndex = viewModel.promotionModel.selectedIndex - 1
        if newIndex < 0 {
            viewModel.promotionModel.selectedIndex = viewModel.itemCountForSection() - 1
            updateUI(isShowAnimation: false)
        } else {
            viewModel.promotionModel.selectedIndex = newIndex
            updateUI()
        }
    }
    
    @objc fileprivate func swipedLeft(){
        stopanimateTVWidget()
//        print("TVWidget swipedLeft")
        animateTVWidget()
    }
}

// MARK: - UICollectionView DataSource, Delegate, Layout
extension PromotionViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCountForSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "IdPromotionViewCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PromotionViewCell {

            if let itemModel = viewModel.itemFor(indexPath: indexPath) {
                cell.updateCellInfo(cellModel: itemModel)
                cell.model?.indexPath = indexPath
            }
//            cell.delegate = self
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        print("Promotional item selected at indexpath:\(indexPath)")
//        let itemModel = viewModel.itemFor(indexPath: indexPath)
//        delegate?.promotionItemTapped(itemModel: itemModel)
//    }

//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        for cell in collectionView.visibleCells {
//            let indexPath = collectionView.indexPath(for: cell)
////            print("Promotional item visible @ \(String(describing: indexPath))")
//            viewModel.promotionModel.selectedIndex = indexPath?.row ?? 0
//            updateUI()
//        }
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}

//// MARK: - STPromotionShortViewControllerDelegate
//extension STPromotionShortViewController: PromotionShortViewCellDelegate {
//    func cellSelected(cellModel: PromotionShortItemModel?) {
//        delegate?.promotionItemTapped(itemModel: cellModel)
//    }
//}

// MARK: - STPromotionShortViewControllerDelegate
extension PromotionViewController: PromotionViewControllerDelegate {
    
    func viewAllTapped() {
        //Default implementation
    }
    
    func promotionItemTapped(itemModel: PromotionItemModel?) {
        //Default implementation
    }
}
