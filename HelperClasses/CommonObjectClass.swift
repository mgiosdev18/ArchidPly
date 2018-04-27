//
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
    

}
