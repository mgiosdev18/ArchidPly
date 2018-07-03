//
//  EmployeeViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 23/05/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit
struct EmployeeData
{
    var EmpID = String()
    var EmpName = String()
}


class EmployeeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchBarDelegate {

    @IBOutlet weak var searchVw: UISearchBar!
    @IBOutlet weak var tblEmployeeList: UITableView!
    
    var arrOfData = [EmployeeData]()
    let arrOfTitleData = ["Emp ID","Emp Name"]
    
    var filteredSearchResults: [EmployeeData]?
    let cellSpacingHeight: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Employee1 : EmployeeData = EmployeeData( EmpID: "5494", EmpName: "Raju")
        let Employee2 : EmployeeData = EmployeeData(EmpID: "306", EmpName: "Siva Kumar")
        let Employee3 : EmployeeData = EmployeeData(EmpID: "364", EmpName: "Ganesh")
        let Employee4 : EmployeeData = EmployeeData(EmpID: "391", EmpName: "Musini")
        let Employee5 : EmployeeData = EmployeeData(EmpID: "5648", EmpName: "Raghavendra")
        let Employee6 : EmployeeData = EmployeeData(EmpID: "2341", EmpName: "NSP")
        let Employee7 : EmployeeData = EmployeeData(EmpID: "09897", EmpName: "Naveen")
        let Employee8 : EmployeeData = EmployeeData(EmpID: "2341", EmpName: "Manjunath")
        let Employee9 : EmployeeData = EmployeeData(EmpID: "8976", EmpName: "Susila")
        let Employee10 : EmployeeData = EmployeeData(EmpID: "0909", EmpName: "Rambabu")
        
        arrOfData = [Employee1,Employee2,Employee3,Employee4,Employee5,Employee6,Employee7,Employee8,Employee9,Employee10]
        
        filteredSearchResults = arrOfData
        
        self.setupTableView()
        self.setupSearchBar()
        
    }
    
    //MARK: - Setup TableView
    func setupTableView() -> Void
    {
        
        self.tblEmployeeList.tableFooterView = UIView()
        self.tblEmployeeList.backgroundColor = UIColor.clear
        self.tblEmployeeList.estimatedRowHeight = 50.0
        self.tblEmployeeList.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - Setup Search bar
    
    func setupSearchBar() -> Void
    {
        searchVw.delegate = self
        
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.init(name: "Ubuntu-Regular", size: 12)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.init(name: "Ubuntu-Regular", size: 12)
        
        searchVw.showsScopeBar = true
        searchVw.scopeButtonTitles = ["Emp ID","Emp Name"]
        searchVw.selectedScopeButtonIndex = 0
        searchVw.scopeBarBackgroundImage = UIImage()
        searchVw.tintColor = UIColor.getCustomOrangeColor()
        searchVw.setScopeBarButtonTitleTextAttributes(convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]), for: UIControl.State.normal)
        
        
        for s in searchVw.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 1.0
                s.layer.borderColor = UIColor.getCustomOrangeColor().cgColor
                s.layer.cornerRadius = 15
                s.clipsToBounds = true
            }
        }
        
    }
    
    //MARK: - Search bar delegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch searchBar.selectedScopeButtonIndex
        {
        case 0:
            filteredSearchResults = searchText.isEmpty ? arrOfData : arrOfData.filter({ (item) -> Bool in
                
                return item.EmpID.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            break
        case 1:
            filteredSearchResults = searchText.isEmpty ? arrOfData : arrOfData.filter({ (item) -> Bool in
                
                return item.EmpName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            break
 
        default:
            break
        }
        
        
        
        self.tblEmployeeList.reloadData()
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchVw.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchVw.showsCancelButton = false
        //self.mySearchBar.text = ""
        self.searchVw.resignFirstResponder()
        self.tblEmployeeList.reloadData()
    }
    //MARK: - tableview Data source and delegate methods..
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return filteredSearchResults!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return arrOfTitleData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeListCell", for: indexPath)
        
        var mainArray = [[String]]()
        
        for item in filteredSearchResults!
        {
            var subArray = [String]()
            
            subArray.append(item.EmpID)
            subArray.append(item.EmpName)
            
            mainArray.append(subArray)
            
        }
        
        
        let string = arrOfTitleData[indexPath.row]
        
        cell.textLabel!.text = string
        cell.textLabel?.textColor = UIColor.getCustomOrangeColor()
        cell.textLabel?.backgroundColor = UIColor.clear
        
        let saleData = mainArray[indexPath.section]
        
        cell.detailTextLabel?.textColor = UIColor.white.withAlphaComponent(0.9)
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        cell.detailTextLabel?.text = saleData[indexPath.row]
        
        // Cell appearance...
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.3)
       // cell.selectionStyle = .none
        //cell.layer.borderColor = UIColor.getCustomOrangeColor().cgColor
        //cell.layer.borderWidth = 1
        //cell.layer.cornerRadius = 25
        //cell.clipsToBounds = true
        
        
        
         // first create UIImageView
        if indexPath.row == 0
        {
            cell.accessoryView?.isHidden = false
             var imageView : UIImageView
             imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: cell.frame.height/2, height: cell.frame.height/2))
             imageView.image = #imageLiteral(resourceName: "rightArrow")
            
             // then set it as cellAccessoryType
             cell.accessoryView = imageView
        }
        else
        {
            
            cell.accessoryView?.isHidden = true
        }
 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
