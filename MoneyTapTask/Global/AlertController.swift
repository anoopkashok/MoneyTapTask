//
//  AlertController.swift
//  MoneyTapTask
//
//  Created by Anoop on 12/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//

import Foundation
import UIKit

class AlertController: NSObject {
    
//Call this function to show any alert message to user
class func showAlertToUser(messageTitle:String, message: String, controller:UIViewController){
    
    let alertController = UIAlertController(title: messageTitle,
                                            message: message,
                                            preferredStyle: .alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    
    controller.present(alertController, animated: true, completion: nil)
    
}
}
