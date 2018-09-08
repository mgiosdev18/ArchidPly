//
//  SalesDetailsViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 27/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct SalesData
{

    var Date = String()
    var Client = String()
    var Manager = String()
    var Invoice = String()
    var Product = String()
    var Amount = String()
    
}


class SalesDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var searchVw: UISearchBar!
    @IBOutlet weak var tblSales: UITableView!
    
    var arrOfData = [SalesData]()
    let arrOfTitleData = ["Date","Client","Manager","Invoice","Product","Amount"]

    var filteredSearchResults: [SalesData]?
    let cellSpacingHeight: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data1 : SalesData = SalesData(Date: "12-May-2017", Client: "Niyanta", Manager: "5494", Invoice: "291", Product: "bon Vivanth", Amount: "862800")
        
         let data2 : SalesData = SalesData(Date: "15-May-2017", Client: "Arunachal boards", Manager: "3456", Invoice: "306", Product: "Natural veneer", Amount: "297549")
        
         let data3 : SalesData = SalesData(Date: "22-May-2017", Client: "Hanuman Wood Industries", Manager: "2765", Invoice: "364", Product: "Rangoon Magic Teak", Amount: "541701")
        
         let data4 : SalesData = SalesData(Date: "25-May-2017", Client: "NSK", Manager: "9878", Invoice: "391", Product: "bon Club Playwood", Amount: "132319")
        
        arrOfData = [data1,data2,data3,data4]
        
        filteredSearchResults = arrOfData
        
        self.setupTableView()
        self.setupSearchBar()
        
    }
    
    //MARK: - Setup TableView
    func setupTableView() -> Void
    {
        
        self.tblSales.tableFooterView = UIView()
        self.tblSales.backgroundColor = UIColor.clear
        self.tblSales.estimatedRowHeight = 50.0
        self.tblSales.rowHeight = UITableView.automaticDimension
    }

    //MARK: - Setup Search bar
    
    func setupSearchBar() -> Void
    {
        searchVw.delegate = self
        
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.init(name: "Ubuntu-Regular", size: 12)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.init(name: "Ubuntu-Regular", size: 12)
        
        searchVw.showsScopeBar = true
        searchVw.scopeButtonTitles = ["Client","Product","Manager"]
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
                
                return item.Client.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            break
        case 1:
            filteredSearchResults = searchText.isEmpty ? arrOfData : arrOfData.filter({ (item) -> Bool in
                
                return item.Product.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            break
        case 2:
            filteredSearchResults = searchText.isEmpty ? arrOfData : arrOfData.filter({ (item) -> Bool in
                
                return item.Manager.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            break
        default:
            break
        }
        
      
        
        self.tblSales.reloadData()
    }
    

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchVw.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchVw.showsCancelButton = false
        //self.mySearchBar.text = ""
        self.searchVw.resignFirstResponder()
        self.tblSales.reloadData()
    }
    //MARK: - tableview Data source and delegate methods..
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return filteredSearchResults!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesCell", for: indexPath)
        
        var mainArray = [[String]]()
        
        for item in filteredSearchResults!
        {
            var subArray = [String]()

            subArray.append(item.Date)
            subArray.append(item.Client)
            subArray.append(item.Manager)
            subArray.append(item.Invoice)
            subArray.append(item.Product)
            subArray.append(item.Amount)
            
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
        cell.selectionStyle = .none
        //cell.layer.borderColor = UIColor.getCustomOrangeColor().cgColor
        //cell.layer.borderWidth = 1
        //cell.layer.cornerRadius = 25
        //cell.clipsToBounds = true
        
        
        /*
        // first create UIImageView
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: cell.frame.height/2, height: cell.frame.height/2))
        imageView.image = #imageLiteral(resourceName: "rightArrow")
        
        // then set it as cellAccessoryType
        cell.accessoryView = imageView
        */
        
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
