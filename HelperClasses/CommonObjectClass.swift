//  CommonObjectClass.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 26/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class CommonObjectClass: NSObject {
    
    func pushTheView(fromVC:UIViewController, toVC:UIViewController, withIdentifier:String) -> Void
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let toView = storyBoard.instantiateViewController(withIdentifier: withIdentifier) 
        fromVC.navigationController?.pushViewController(toView, animated: true)
 
    }
    
    func DisableButtons(buttons: [UIButton], withBackgroundColor: UIColor) -> Void {
        
        for btn in buttons {
            
            btn.backgroundColor = withBackgroundColor
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.getCustomGreyColor().cgColor
            btn.isUserInteractionEnabled = false
            btn.setTitleColor(UIColor.getCustomGreyColor(), for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 5
        }
        
        
    }
    
    func EnableButtons(buttons: [UIButton] , withBackgroundColor: UIColor)  -> Void {
        
        for btn in buttons
        {
            btn .backgroundColor = withBackgroundColor
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.white.cgColor
            btn.isUserInteractionEnabled = true
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 5
        }
        
    }
    
    func currentdatetime() -> String {
        let dateFormatter = DateFormatter()
       // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = NSTimeZone.local
        return "\( dateFormatter.string(from: NSDate() as Date))"
    }

}
