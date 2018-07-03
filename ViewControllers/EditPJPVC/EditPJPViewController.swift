//
//  EditPJPViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 27/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class EditPJPViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    @IBOutlet weak var txtFieldTodayDate: UITextField!
    @IBOutlet weak var customerListSearchField: SearchTextField!
    @IBOutlet weak var txtVwPurposeOfVisit: UITextView!
    @IBOutlet weak var txtFieldNextVisitDate: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextfield()
        CommonObjectClass().EnableButtons(buttons: [btnSave], withBackgroundColor: .getCustomOrangeColor())
        
        txtVwPurposeOfVisit.setBottomBorder(withColor: UIColor.getCustomOrangeColor())
        txtVwPurposeOfVisit.textColor = PlaceHolderColor
        txtFieldTodayDate.text = "Today : \(CommonObjectClass().currentdatetime())"
        
    }
    //MARK: - Helper Methods
    
    func setupTextfield ()
    {
        // txtFieldTodayDate
        txtFieldTodayDate.setBottomBorder(withColor: UIColor.getCustomOrangeColor())
        txtFieldTodayDate.setValue(PlaceHolderColor, forKeyPath: "_placeholderLabel.textColor")

        // txtFieldNextVisitDate
        txtFieldNextVisitDate.layer.borderColor = UIColor.white.cgColor
        txtFieldNextVisitDate.layer.borderWidth = 1
        txtFieldNextVisitDate.layer.cornerRadius = 5
        txtFieldNextVisitDate.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")

        
        //        let item1 = SearchTextFieldItem(title: "Blue", subtitle: "", image: nil)
        //        let item2 = SearchTextFieldItem(title: "Red", subtitle: "", image: nil)
        //        let item3 = SearchTextFieldItem(title: "Yellow", subtitle: "", image: nil)
        
        customerListSearchField.theme = SearchTextFieldTheme.darkTheme()
        customerListSearchField.theme.bgColor = UIColor.black
        customerListSearchField.theme.separatorColor = UIColor.getCustomOrangeColor()
        customerListSearchField.theme.cellHeight = 40
        customerListSearchField.backgroundColor = UIColor.black
        customerListSearchField.theme.font = UIFont.systemFont(ofSize: 14)
        customerListSearchField.highlightAttributes = [NSAttributedStringKey.foregroundColor: UIColor.getCustomOrangeColor(), NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]
        customerListSearchField.setValue(PlaceHolderColor, forKeyPath: "_placeholderLabel.textColor")
        customerListSearchField.setBottomBorder(withColor: UIColor.getCustomOrangeColor())

        // Set the array of strings you want to suggest
        customerListSearchField.filterStrings(["navkar glass", "SRI LAKSHMI VIJAYA SAW MILL", "Heda Plywood","E Cube Architects","Design Qube","CDE","P R Design","VSDP","Prakash","Prasad Dr","Ace group"])
        
        customerListSearchField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            // Do whatever you want with the picked item
            self.customerListSearchField.text = item.title
            self.customerListSearchField.resignFirstResponder()
        }
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "downArrow"))
        imageView.contentMode = UIViewContentMode.center
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.image!.size.width + 20.0, height: imageView.image!.size.height)
        customerListSearchField.rightViewMode = UITextFieldViewMode.always
        customerListSearchField.rightView = imageView
        
    }
    //MARK: - UITextField Delegae Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 2
        {
            
            let alert = UIAlertController(style: .actionSheet, title: "Select Next Visit date")
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                // action with selected date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let strDate = dateFormatter.string(from: date)
                textField.textColor = UIColor.white
              
                textField.text = "Next Visit Date : \(strDate)"
                
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let strDate = dateFormatter.string(from: Date())
            textField.textColor = UIColor.white
            if textField.tag == 2
            {
                textField.text = "Next Visit Date : \(strDate)"
            }

            alert.addAction(title: "OK", style: .cancel)
            alert.show()
            
            return false
        }
        
        return true
        
    }
    //MARK: - UITextView Delegate methods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
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
