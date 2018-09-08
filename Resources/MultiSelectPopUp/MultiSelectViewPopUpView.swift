//
//  MultiSelectViewPopUpView.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 15/06/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MultiSelectViewPopUpView: UIViewController, UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tblMultiSelect: UITableView!
    let cellSpacingHeight: CGFloat = 10
    var selectedCells = [Int]()
    var selectedValues = [String]()
    
    
    let arrCataloguePOP = ["Navakar glass","SRI Lakshmi Vijaya Sai Mill","Karnataka Saw Mills","Veedu Architects","Anand Enterprises","CDE","RamRaj", "Sagar plywood","Rajiv exports","Subhod extensions","Ganesh apartments","Nayagara archade"]
    
    var didSelectItem: ((_ selectedItem: [Int],_ seletedValues:[String]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        CommonObjectClass().EnableButtons(buttons: [btnCancel,btnSubmit], withBackgroundColor: .getCustomOrangeColor())
        
        self.showAnimate()
        self.setupTableView()

    }
    @IBAction func btnCancelClicked(_ sender: UIButton)
    {
        self.removeAnimate()
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton)
    {
        self.removeAnimate()
        
        didSelectItem?(selectedCells,selectedValues)
        
    }
    
    //MARK: - Setup TableView
    func setupTableView() -> Void
    {
        
        self.tblMultiSelect.tableFooterView = UIView()
        self.tblMultiSelect.backgroundColor = UIColor.clear
    }
    
    func showAnimate()
    {
        self.navigationController?.isNavigationBarHidden = true

        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
        
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
        self.navigationController?.isNavigationBarHidden = false
    }
    //MARK: - tableview Data source and delegate methods..
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrCataloguePOP.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiSelectCell", for: indexPath)
 
        cell.textLabel!.text = arrCataloguePOP[indexPath.section]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.backgroundColor = UIColor.clear
 
        // Cell appearance...
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        cell.layer.borderColor = UIColor.getCustomOrangeColor().cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true
        
        /*
        // first create UIImageView
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: cell.frame.height/2, height: cell.frame.height/2))
        imageView.image = #imageLiteral(resourceName: "rightArrow")
        
        // then set it as cellAccessoryType
        cell.accessoryView = imageView
 
         */
        

        
        cell.accessoryType = self.selectedCells.contains(indexPath.section) ? .checkmark : .none

        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        if self.selectedCells.contains(indexPath.section) {
            self.selectedValues.remove(at: self.selectedCells.index(of: indexPath.section)!)
            self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.section)!)
        } else {
            self.selectedCells.append(indexPath.section)
            self.selectedValues.append(self.arrCataloguePOP[indexPath.section])
        }

        
        tableView.reloadData()
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
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
