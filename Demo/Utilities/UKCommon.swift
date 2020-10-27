//
//  UKCommon.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation
import UIKit

class UKCommon: NSObject {
    
static let sharedInstance = UKCommon()
    typealias AlertTapHandler = () -> Void

    static func showCommonAlert(with message: String = "Not Implemented.", on viewController: UIViewController? = nil, showCancel: Bool? = false, okAction: AlertTapHandler? = nil, cancelAction: AlertTapHandler? = nil) {
        let alert = UIAlertController(title: "product.title".localized, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
            DispatchQueue.main.async {
                okAction?()
            }
        }))
        
        if showCancel! {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                cancelAction?()
            }))
        }
        
        if let presenter = viewController {
            DispatchQueue.main.async {
                presenter.present(alert, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                let mainWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                mainWindow?.rootViewController!.present(alert, animated: true, completion: nil)
            }
        }
    }
    static func showAlert(with message: String? = "",
                          on viewController: UIViewController? = nil,
                          okAction: (() -> Void)? = nil,
                          cancelAction: (() -> Void)? = nil,
                          okButtonTitle: String? = "Yes",
                          cancelButtonTitle: String? = "Cancel")
    {
        let alert = UIAlertController(title: UKConstants.kAppName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okButtonTitle, style: UIAlertAction.Style.default, handler:
            {
                _ in
                DispatchQueue.main.async
                    {
                        okAction?()
                }
        }))
        
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler:
            {
                _ in
                DispatchQueue.main.async
                    {
                        cancelAction?()
                }
        }))
        
        if let presenter = viewController {
            DispatchQueue.main.async {
                presenter.present(alert, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                let mainWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                mainWindow?.rootViewController!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    static func showErrorMessage(error: NSError) {
        
       UKCommon.showCommonAlert(with: error.localizedDescription)
    }
    
    static func showServerConnectivityMessage() {
        
        UKCommon.showCommonAlert(with: "Server is not available.")
    }
    
    static func showNoInternetConnectivityMessage() {
        
        UKCommon.showCommonAlert(with: "No internet connection available.")
    }
    
    static func showWeakInternetConnectivityMessage() {
        
        UKCommon.showCommonAlert(with: "Internet connectivity is not available.")
    }
 
}
