//
//  AddNewClientViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 27/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class AddNewClientViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate {
    @IBOutlet weak var ScrollVC: UIScrollView!
    @IBOutlet weak var ContectScrollVw: UIView!
    
    @IBOutlet weak var PartyNameField: UITextField!
    @IBOutlet weak var ContactPersonNameField: UITextField!
    @IBOutlet weak var PhoneNumberField: UITextField!
    @IBOutlet weak var EmailAddressField: UITextField!
    @IBOutlet weak var DOBField: UITextField!
    @IBOutlet weak var WeddingAnniversaryField: UITextField!
    @IBOutlet weak var CustomerListSearchField: SearchTextField!
  
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet var txtFieldsColln: [UITextField]!
    @IBOutlet weak var txtVwAddress: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    var strTxtViewText = String()
    var activeField : UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    var datePicker : UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for Tfields in txtFieldsColln
        {
            if Tfields.tag == 5 || Tfields.tag == 6
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
 
        
        self.setupTextView()
        self.addDoneButtonOnKeyboard(TxtField: PhoneNumberField)
        self.setupSearchTextfield()
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
       CommonObjectClass().EnableButtons(buttons: [btnSave], withBackgroundColor: UIColor.getCustomOrangeColor())
        
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        ScrollVC.contentSize = CGSize(width: ScrollVC.frame.size.width, height: ContectScrollVw.frame.size.height)
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
                self.constraintContentHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            if activeField != nil
            {
            let distanceToBottom = self.ScrollVC.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
                
                if collapseSpace < 0 {
                    // no collapse
                    return
                }
                
                // set new offset for scroll view
                UIView.animate(withDuration: 0.3, animations: {
                    // scroll to the position above keyboard 10 points
                    self.ScrollVC.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
                })
            }
            
        
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if keyboardHeight == nil {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight
            
            self.ScrollVC.contentOffset = self.lastOffset
        }
        
        keyboardHeight = nil
    }
    
    //MARK: - Helper Methods
    func setupTextView() -> Void
    {
        // Add bottom border
        txtVwAddress.setBottomBorder(withColor: UIColor.getCustomOrangeColor())
        txtVwAddress.textColor = PlaceHolderColor
        
     }
    func setupSearchTextfield ()
    {
        //        let item1 = SearchTextFieldItem(title: "Blue", subtitle: "", image: nil)
        //        let item2 = SearchTextFieldItem(title: "Red", subtitle: "", image: nil)
        //        let item3 = SearchTextFieldItem(title: "Yellow", subtitle: "", image: nil)
        
        CustomerListSearchField.theme = SearchTextFieldTheme.darkTheme()
        CustomerListSearchField.theme.bgColor = UIColor.black
        CustomerListSearchField.theme.separatorColor = UIColor.getCustomOrangeColor()
        CustomerListSearchField.theme.cellHeight = 40
        CustomerListSearchField.backgroundColor = UIColor.black
        CustomerListSearchField.theme.font = UIFont.systemFont(ofSize: 14)
        CustomerListSearchField.highlightAttributes = [NSAttributedString.Key.foregroundColor: UIColor.getCustomOrangeColor(), NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)]

        // Set the array of strings you want to suggest
        CustomerListSearchField.filterStrings(["OEM", "Corporates", "Architects","Contractor","Dealers","Site Visits"])
        
        CustomerListSearchField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            // Do whatever you want with the picked item
            self.CustomerListSearchField.text = item.title
        }
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "downArrow"))
        imageView.contentMode = UIView.ContentMode.center
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.image!.size.width + 20.0, height: imageView.image!.size.height)
        CustomerListSearchField.rightViewMode = UITextField.ViewMode.always
        CustomerListSearchField.rightView = imageView

    }


    
    func addDoneButtonOnKeyboard(TxtField:UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
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
        self.PhoneNumberField.resignFirstResponder()
    }
  
    //MARK: - UITextView Delegate methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let color = textView.tintColor
        textView.tintColor = .clear
        textView.tintColor = color
        
        if textView.textColor == PlaceHolderColor
        {
            textView.text = nil
            textView.textColor = UIColor.white
        }
        
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
 
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty
        {
            textView.text = "Client Address"
            textView.textColor = PlaceHolderColor
            
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        
        //  print("\(textView.text)")
        
        self.strTxtViewText = textView.text
        
        let size = CGSize(width: self.view.frame.width, height: .infinity)
        
        let estimatedSize =  textView.sizeThatFits(size)
        
        //  print("\(estimatedSize.height)")
        
        if estimatedSize.height >= 60.0
        {
            txtVwAddress.constraints.forEach { (constraint) in
                
                if constraint.firstAttribute == .height
                {
                    constraint.constant = estimatedSize.height
                }
            }
        }
 
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: - UITextField Delegae Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 5 || textField.tag == 6
        {
            var alert_title = ""
            
            if textField.tag == 5
            {
                alert_title = "Select Date of Birth"
            }
            else if textField.tag == 6
            {
    
                alert_title = "Select Wedding Date"
                    
            }
            
            let alert = UIAlertController(style: .actionSheet, title: alert_title)
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                // action with selected date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let strDate = dateFormatter.string(from: date)
                textField.textColor = UIColor.white
                if textField.tag == 5
                {
                    textField.text = "Date of Birth : \(strDate)"
                }
                else
                if textField.tag == 6
                {
                    textField.text = "Wedding Date : \(strDate)"
                    
                }
                
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let strDate = dateFormatter.string(from: Date())
            textField.textColor = UIColor.white
            if textField.tag == 5
            {
                textField.text = "Date of Visit : \(strDate)"
            }
            else if textField.tag == 6
            {
                textField.text = "Praposed Next Visit Date : \(strDate)"
            }
            
            
            
            alert.addAction(title: "OK", style: .cancel)
            alert.show()
            
            return false
        }
        else
        {
            activeField = textField
            lastOffset = self.ScrollVC.contentOffset
            return true
        }
       
    }
 
    
    @IBAction func btnSaveClicked(_ sender: UIButton)
    {
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
