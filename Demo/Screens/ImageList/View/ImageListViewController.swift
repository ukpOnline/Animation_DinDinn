//
//  HomeListViewController.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HomeListViewController: UKBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelNoItem: UILabel!
    @IBOutlet weak var lblItemCount: UILabel!
    
    
    // MARK: - Variables
    let segueDetailsPage = "detailsPage"
    var viewModel: ImageListViewModel?
    var selectedIndexPath: IndexPath?
    var itemSelected: Int = 0
    
    // MARK: - Initilizations Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = ImageListViewModel()
    }
    
    init(with viewModel: ImageListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Overrided Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.getImageItems()

        self.initializeUI()
    }
    
    // MARK: - Public Methods
    
    
    // MARK: - Private Methods

    @objc func handleSwipe(sender: UISwipeGestureRecognizer)  {
        let direction = sender.direction
        switch direction {
        case .right:
            print("Gesture direction: Right")
        case .left:
            print("Gesture direction: Left")
            swipedLeft()
        case .up:
            print("Gesture direction: Up")
        case .down:
            print("Gesture direction: Down")
        default:
            print("Unrecognized Gesture Direction")
        }
    }
    
    fileprivate func initializeUI() {
        lblItemCount.text = ""
        lblItemCount.backgroundColor = UIColor.green
        lblItemCount.makeRounded()
        lblItemCount.isHidden = true
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.left]//.right,, .up, .down
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.collectionView.addGestureRecognizer(gesture)
        }
    }
    
    fileprivate func updateUI() {
        DispatchQueue.main.async {
            self.labelNoItem.isHidden = (self.viewModel?.itemsCout() ?? 0) > 0
            self.viewModel?.updateDummyData()
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func swipedLeft() {
        var category =  viewModel?.categoryItems
        category?.remove(at: 0)
        let prevItem = viewModel?.selectedCategory ?? .pizza
        category?.append(prevItem)
        viewModel?.categoryItems = category!
        viewModel?.selectedCategory = viewModel?.categoryItems[0] ?? .pizza as CategoryItems
        
        collectionView.reloadData()
    }
    //MARK: - Navigation Methods -
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailsPage {
            let viewcontroller = segue.destination as! DetailsViewController
            if let indexPath = selectedIndexPath, let itemInfo = self.viewModel?.itemModelForRow(indexPath: indexPath) {
                let itemDetail = DetailModel(identifier: itemInfo.imgId, authorName: itemInfo.authorName ?? "n.a." )
                viewcontroller.viewModel = DetailsViewModel(withItemInfo: itemDetail)
            }
        }
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        //        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}

// MARK: - ImageListViewModelDelegate

extension HomeListViewController: ImageListViewModelDelegate {
    
    func itemlistReceived(){
        self.updateUI()
    }
    
    func dataErrorOccured(message: String) {
        print("Service failed with error:\(message)")
        UKCommon.showCommonAlert(with: message, on: self)
        self.updateUI()
    }

}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension HomeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.viewModel?.categoryItems.count ?? 0
        } else {
            return self.viewModel?.itemsCout() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard  let cell: CategoryViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.reUseIdentifier, for: indexPath) as? CategoryViewCell  else {
                fatalError("category cell not found")
            }
            cell.isCategorySelected = indexPath.row == 0
            let title = self.viewModel?.categoryItems[indexPath.row].displayName() ?? "n.a"
            cell.updateCellInfo(title: title)
            return cell
        } else {
            
            if viewModel?.selectedCategory == .pizza {
                guard  let cell: ItemListViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListViewCell.reUseIdentifier, for: indexPath) as? ItemListViewCell  else {
                    fatalError("ItemListViewCell not found")
                }
                
                if let itemInfo = self.viewModel?.itemModelForRow(indexPath: indexPath) {
                    
                    cell.itemData = itemInfo
                    cell.cellImage.sd_setShowActivityIndicatorView(true)
                    cell.cellImage.sd_setIndicatorStyle(.gray)
                    let imageURL = URL.init(string: "\(ImageURL.baseURL)\(itemInfo.imgId)")
                    cell.cellImage.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "noItemImage"), options: [.progressiveDownload])
                    cell.titleIndicator.isHidden = indexPath.row != 0
                    cell.updateItem(imageName: nil)

                    cell.delegate = self

                }
                //Using from the WebService
                //let imgName = "item_\(indexPath.row % 13)"
                //cell.updateItem(imageName: imgName)
                return cell
            } else if viewModel?.selectedCategory == .sushi {
                guard  let cell: ItemListViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListViewCell.reUseIdentifier, for: indexPath) as? ItemListViewCell  else {
                    fatalError("ItemListViewCell not found")
                }
                let imgName = "multi_\(indexPath.row % 8)"
                cell.titleIndicator.isHidden = true
                cell.updateItem(imageName: imgName)
                cell.delegate = self
                return cell
                
            } else {//.Drinks
                guard  let cell: ItemListViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListViewCell.reUseIdentifier, for: indexPath) as? ItemListViewCell  else {
                    fatalError("ItemListViewCell not found")
                }
                let imgName = "drinks_\(indexPath.row % 14)"
                cell.titleIndicator.isHidden = true
                cell.updateItem(imageName: imgName)
                cell.delegate = self
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionView1", for: indexPath) as? HeaderReusableView
                //             sectionHeader.label.text = "TRENDING"
            sectionHeader?.isHideItem = indexPath.section == 0
            sectionHeader?.updateUI()
            return sectionHeader ??  UICollectionReusableView()
            
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.frame.width, height: 40)
        } else {
            return CGSize(width: collectionView.frame.width, height: 1)
        }
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedIndexPath = indexPath
//        self.performSegue(withIdentifier: segueDetailsPage, sender: self)
//    }

}

// MARK: - UICollectionViewDelegateFlowLayout -
extension HomeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemWidth: CGFloat  = collectionView.frame.width
        var itemHeight: CGFloat = 280.0
        
        if indexPath.section == 0 {
            itemWidth = (collectionView.frame.width - 2 )/3
            itemHeight = 40.0
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

// MARK: - ItemListViewCellDelegate
extension HomeListViewController: ItemListViewCellDelegate{
    func itemSelected(model: ItemModel?){

        itemSelected += 1
        lblItemCount.text = " \(itemSelected) "
        lblItemCount.makeRounded()
        lblItemCount.isHidden = false
        lblItemCount.layoutSubviews()
    }

}
