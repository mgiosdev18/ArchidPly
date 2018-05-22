//
//  ClientHistoryDetailsViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 22/05/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct HistoyDetails
{
    
    var CustomerType = String()
    var Address = String()
    var Email = String()
    var Mobile = String()
    var PurposeofVisit = String()
    var LastVisit = String()
    var ProjectStart = String()
    var ProjectEnd = String()
    var ProductCategory = String()
    var NextVisit = String()
    
}

class ClientHistoryDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblHistoryDetails: UITableView!
    
    var arrOfData = [HistoyDetails]()
    let arrOfTitleData = ["Customer Type","Address","Email","Mobile","Purpose of Visit","Last Visit","Project Start","Project End","Product Category","Next Visit"]
    
    var filteredSearchResults: [HistoyDetails]?
    let cellSpacingHeight: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let details = HistoyDetails(CustomerType: "Contractors", Address: "Opp RTC complex, Rajahmundry,West Godavary,Andhra pradesh,India", Email: "tester@gmail.com", Mobile: "9867865490", PurposeofVisit: "Wanted plywood, to check with the manager", LastVisit: "", ProjectStart: "", ProjectEnd: "", ProductCategory: "None", NextVisit: "14-June-2018")
        
     
        arrOfData = [details]
        
        filteredSearchResults = arrOfData
        
        self.setupTableView()
        
    }
    
    @IBAction func btnBackClicked(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Setup TableView
    func setupTableView() -> Void
    {
        
        self.tblHistoryDetails.tableFooterView = UIView()
        self.tblHistoryDetails.backgroundColor = UIColor.clear
        self.tblHistoryDetails.estimatedRowHeight = 50.0
        self.tblHistoryDetails.rowHeight = UITableViewAutomaticDimension
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientHistoryDetailsCell", for: indexPath)
        
        var mainArray = [[String]]()
                
        for item in filteredSearchResults!
        {
            var subArray = [String]()
            
            subArray.append(item.CustomerType)
            subArray.append(item.Address)
            subArray.append(item.Email)
            subArray.append(item.Mobile)
            subArray.append(item.PurposeofVisit)
            subArray.append(item.LastVisit)
            subArray.append(item.ProjectStart)
            subArray.append(item.ProjectEnd)
            subArray.append(item.ProductCategory)
            subArray.append(item.NextVisit)
            
            mainArray.append(subArray)
            
        }
        
        
        let string = arrOfTitleData[indexPath.row]
        
        cell.textLabel!.text = string
        let saleData = mainArray[indexPath.section]
        cell.detailTextLabel?.text = saleData[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor.white.withAlphaComponent(0.9)
        
        // Cell appearance...
        cell.backgroundColor = UIColor.clear
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
