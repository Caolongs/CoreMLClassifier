//
//  UIAlertController+Extension.swift
//  CMLFlowerClassifier
//
//  Created by cao longjian on 2017/11/2.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// Single button alert
    ///
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - buttonText: buttonText
    ///   - completion: completion
    /// - Returns: UIAlertController
    @discardableResult
    public class func jj_singleButtonAlertWithTitle(
        _ title: String,
        message: String,
        buttonText: String? = "OK",
        completion:(() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { (action: UIAlertAction!) in
            if let completion = completion {
                completion()
            }
        }))
        alert.jj_show()
        return alert
        
    }
    
    /// Double button alert
    ///
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - buttonText: buttonText
    ///   - completion: completion
    /// - Returns: UIAlertController
    @discardableResult
    public class func jj_doubleButtonAlertWithTitle(
        _ title: String,
        message: String,
        buttonText: String? = "OK",
        otherButtonTitle: String,
        completion: (() -> Void)?) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: otherButtonTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            if let completion = completion {
                completion()
            }
        }))
        alert.jj_show()
        return alert
    }
    
    /// ActionSheet
    ///
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - actionArr: actionArr
    ///   - cancle: cancle
    ///   - completion: completion
    /// - Returns: UIAlertController
    @discardableResult
    public class func jj_actionSheetWithTitle(
        _ title: String? = nil,
        message: String? = nil,
        actionArr: [String],
        cancle: String? = "Cancle",
        completion:((_ idx: Int) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for str: String in actionArr {
            alert.addAction(UIAlertAction(title: str, style: .default, handler: { (action: UIAlertAction!) in
                if let completion = completion {
                    completion(actionArr.index(of: str)!)
                }
            }))
        }
        alert.addAction(UIAlertAction(title: cancle, style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        
        alert.jj_show()
        return alert
        
    }
    

    private func jj_show() {
        self.jj_present(true, completion: nil)
    }
    
    private func jj_present(_ animation: Bool, completion:(() -> Void)?) {
        if let rootVC =  UIApplication.shared.keyWindow?.rootViewController {
            self.jj_presentFromController(rootVC, animated: animation, completion: completion)
        }
    }
    
    private func jj_presentFromController(_ controller: UIViewController, animated: Bool, completion:(() -> Void)?) {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            self.jj_presentFromController(visibleVC, animated: animated, completion: completion)
        } else {
            controller.present(self, animated: animated, completion: completion);
        }
        
    }
}

