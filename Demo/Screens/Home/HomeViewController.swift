//
//  HomeViewController.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage

class HomeViewController: UKBaseViewController {
    // MARK: - IBoutlets

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var itemListView: UIView!
    @IBOutlet weak var itemListViewTopConstraint: NSLayoutConstraint!
    // MARK: - Variables

    // MARK: - Overrided Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.itemListViewTopConstraint.constant = 580.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            self.animateShowTop()
        })
    }
    
    // MARK: - Private Methods
    fileprivate func animateShowTop(){
        UIView.animate(withDuration: 4, delay: 0.0, options: [.curveEaseOut],
                       animations: {
                        self.itemListViewTopConstraint.constant = 0
                        self.itemListView.center = self.view.center
                        self.itemListView.layoutIfNeeded()
        },  completion: {(_ completed: Bool) -> Void in
            self.itemListView.isHidden = false
        })
    }
}
