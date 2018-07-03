//
//  DailyVisitEntryViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 27/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class DailyVisitEntryViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var selectDataOfVisitField: UITextField!
    @IBOutlet weak var customerTypeField: SearchTextField!
    @IBOutlet weak var customerNameField: SearchTextField!
    @IBOutlet weak var addressTextVw: UITextView!
    @IBOutlet weak var cellNumberField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var purposeOfVisitField: UITextField!
    @IBOutlet weak var selectCatalogueAndPOPField: UITextField!
    @IBOutlet weak var praposedNextVisitDate: UITextField!
    @IBOutlet weak var createNewProjectField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollVC: UIScrollView!
    @IBOutlet var txtFieldsColln: [UITextField]!
    @IBOutlet weak var ConstraintContentHeight: NSLayoutConstraint!
    
    var activeField : UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    var multiSelectValues = [String]()
    var selectedCells = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for Tfields in txtFieldsColln
        {
            if Tfields.tag == 1 || Tfields.tag == 8 || Tfields.tag == 9
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

        self.showingArrowToTextFields()
        self.setupTextView()
        self.setupSearchTextfield()
        CommonObjectClass().EnableButtons(buttons: [btnSave], withBackgroundColor: UIColor.getCustomOrangeColor())

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
    func setupTextView() -> Void
    {
        // Add bottom border
        addressTextVw.setBottomBorder(withColor: UIColor.getCustomOrangeColor())
        addressTextVw.textColor = PlaceHolderColor
        
    }
    func showingArrowToTextFields() -> Void
    {
        
        let nextArrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        nextArrowImage.image = #imageLiteral(resourceName: "rightArrow")
        createNewProjectField.rightView = nextArrowImage
        createNewProjectField.rightViewMode = .always
        
        let downArrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        downArrowImage.image = #imageLiteral(resourceName: "downArrow")
        selectCatalogueAndPOPField.rightView = downArrowImage
        selectCatalogueAndPOPField.rightViewMode = .always
        
    }
    func setupSearchTextfield ()
    {
        //        let item1 = SearchTextFieldItem(title: "Blue", subtitle: "", image: nil)
        //        let item2 = SearchTextFieldItem(title: "Red", subtitle: "", image: nil)
        //        let item3 = SearchTextFieldItem(title: "Yellow", subtitle: "", image: nil)
        
        customerTypeField.theme = SearchTextFieldTheme.darkTheme()
        customerTypeField.theme.bgColor = UIColor.black
        customerTypeField.theme.separatorColor = UIColor.getCustomOrangeColor()
        customerTypeField.theme.cellHeight = 40
        customerTypeField.backgroundColor = UIColor.black
        customerTypeField.theme.font = UIFont.systemFont(ofSize: 14)
        customerTypeField.highlightAttributes = [NSAttributedString.Key.foregroundColor: UIColor.getCustomOrangeColor(), NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)]
        
        // Set the array of strings you want to suggest
        customerTypeField.filterStrings(["OEM", "Corporates", "Architects","Contractor","Dealers","Site Visits"])
        
        customerTypeField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            // Do whatever you want with the picked item
            self.customerTypeField.text = item.title
        }
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "downArrow"))
        imageView.contentMode = UIView.ContentMode.center
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.image!.size.width + 20.0, height: imageView.image!.size.height)
        customerTypeField.rightViewMode = UITextField.ViewMode.always
        customerTypeField.rightView = imageView
        
    }
    
    //MARK: - UITextField Delegae Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1 || textField.tag == 8
        {
            var alert_title = ""
            
            if textField.tag == 1
            {
                alert_title = "Select Date of Visit"
            }
            else if textField.tag == 8
            {
                
                alert_title = "Select Praposed Next Visit Date"
                
            }
            
            let alert = UIAlertController(style: .actionSheet, title: alert_title)
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                // action with selected date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let strDate = dateFormatter.string(from: date)
                textField.textColor = UIColor.white
                if textField.tag == 1
                {
                    textField.text = "Date of Visit : \(strDate)"
                }
                else if textField.tag == 8
                {
                    textField.text = "Praposed Next Visit Date : \(strDate)"
                }
                
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let strDate = dateFormatter.string(from: Date())
            textField.textColor = UIColor.white
            if textField.tag == 1
            {
                textField.text = "Date of Visit : \(strDate)"
            }
            else if textField.tag == 8
            {
                textField.text = "Praposed Next Visit Date : \(strDate)"
            }
            
            
            
            alert.addAction(title: "OK", style: .cancel)
            alert.show()
            
            return false
        }
        else if textField.tag == 7
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
