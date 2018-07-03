//
//  CreateNewProjectViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 16/06/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class CreateNewProjectViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var ProjectOrSiteNameField: UITextField!
    @IBOutlet weak var ProjectStartDateField: UITextField!
    @IBOutlet weak var ProjectEndDateField: UITextField!
    @IBOutlet weak var ProductListField: UITextField!
    @IBOutlet weak var EstimatedAmountField: UITextField!
    @IBOutlet weak var InfluencerNameField: SearchTextField!
    @IBOutlet weak var AddressField: UITextField!
    @IBOutlet weak var LocationOfProjectField: UITextField!
    
    @IBOutlet weak var scrollVC: UIScrollView!
    @IBOutlet weak var ContentScrollVC: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var ConstraintContentHeight: NSLayoutConstraint!
    @IBOutlet var txtFieldsColln: [UITextField]!
    
    var activeField : UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    var multiSelectValues = [String]()
    var selectedCells = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for Tfields in txtFieldsColln
        {
            if Tfields.tag == 2 || Tfields.tag == 3
            {
                Tfields.layer.borderColor = UIColor.white.cgColor
                Tfields.layer.borderWidth = 1
                Tfields.layer.cornerRadius = 5
                Tfields.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
                
            }
            else
            {
                Tfields.setBottomBorder(withColor: UIColor.getCustomOrangeColor())
                Tfields.textColor = UIColor.white
                Tfields.setValue(PlaceHolderColor, forKeyPath: "_placeholderLabel.textColor")
                
            }
            
        }
        
        self.addDoneButtonOnKeyboard(TxtField: EstimatedAmountField)
        self.showingArrowToTextFields()

        CommonObjectClass().EnableButtons(buttons: [btnSave], withBackgroundColor: .getCustomOrangeColor())
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    }
    // MARK: - Keyboard Handling
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.ConstraintContentHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            if activeField != nil
            {
                let distanceToBottom = self.scrollVC.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
                let collapseSpace = keyboardHeight - distanceToBottom
                
                if collapseSpace < 0 {
                    // no collapse
                    return
                }
                
                // set new offset for scroll view
                UIView.animate(withDuration: 0.3, animations: {
                    // scroll to the position above keyboard 10 points
                    self.scrollVC.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
                })
            }
            
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if keyboardHeight == nil {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.ConstraintContentHeight.constant -= self.keyboardHeight
            
            self.scrollVC.contentOffset = self.lastOffset
        }
        
        keyboardHeight = nil
    }
    
    
    //MARK: - Helper Methods
    
    func showingArrowToTextFields() -> Void
    {
        
        let nextArrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        nextArrowImage.image = #imageLiteral(resourceName: "rightArrow")
        ProductListField.rightView = nextArrowImage
        ProductListField.rightViewMode = .always
        
        let downArrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        downArrowImage.image = #imageLiteral(resourceName: "downArrow")
        InfluencerNameField.rightView = downArrowImage
        InfluencerNameField.rightViewMode = .always
        
    }
    
    func addDoneButtonOnKeyboard(TxtField:UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.black
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        TxtField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        activeField?.resignFirstResponder()
        activeField = nil
       // self.EstimatedAmountField.resignFirstResponder()
    }
    
    
    //MARK: - UITextField Delegae Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 2 || textField.tag == 3
        {
            var alert_title = ""
            
            if textField.tag == 2
            {
                alert_title = "Select Project Start Date"
            }
            else if textField.tag == 3
            {
                
                alert_title = "Select Proect End Date"
                
            }
            
            let alert = UIAlertController(style: .actionSheet, title: alert_title)
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                // action with selected date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let strDate = dateFormatter.string(from: date)
                textField.textColor = UIColor.white
                if textField.tag == 2
                {
                    textField.text = "Project Start Date : \(strDate)"
                }
                else if textField.tag == 3
                {
                    textField.text = "Project End Date : \(strDate)"
                }
                
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let strDate = dateFormatter.string(from: Date())
            textField.textColor = UIColor.white
            if textField.tag == 2
            {
                textField.text = "Project Start Date : \(strDate)"
            }
            else if textField.tag == 3
            {
                textField.text = "Project End Date : \(strDate)"
            }
                        
            alert.addAction(title: "OK", style: .cancel)
            alert.show()
            
            return false
        }
        else if textField.tag == 4
        {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MultiSelectViewPopUpView") as! MultiSelectViewPopUpView
            popOverVC.didSelectItem = { (selectedIndex : [Int],selectedValues:[String]) -> () in
                
                if selectedIndex.count > 0
                {
                    self.selectedCells = selectedIndex
                    self.multiSelectValues = selectedValues
                    textField.text = selectedValues.joined(separator: ",")
 
                }
                else
                {
                    textField.text = ""
                    
                    self.selectedCells = []
                    self.multiSelectValues = []
                }
            }
            self.addChild(popOverVC)
            popOverVC.view.bounds = self.view.bounds
            self.view.addSubview(popOverVC.view)
            popOverVC.selectedCells = self.selectedCells
            popOverVC.selectedValues = self.multiSelectValues
            popOverVC.didMove(toParent: self)
            
            return false
        }
        else if textField.tag == 9
        {
            
            self.performSegue(withIdentifier: "CreateNewProject", sender: self)
            
            return false
        }
        else
        {
            activeField = textField
            lastOffset = self.scrollVC.contentOffset
            return true
        }
        
    }
    
    
    deinit {
       // NotificationCenter.default.removeObserver(self)
    }

    @IBAction func btnSaveClicked(_ sender: UIButton)
    {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
