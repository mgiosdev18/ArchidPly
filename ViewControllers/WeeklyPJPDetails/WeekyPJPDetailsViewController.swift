//
//  WeekyPJPDetailsViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 23/05/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct weeklyPJPDetails
{
    var Address = String()
    var PurposeofVisit = String()
    var NextVisitDiscussion = String()
    
}

class WeekyPJPDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblWeeklyPJPDetails: UITableView!

    var arrOfData = [weeklyPJPDetails]()
    let arrOfTitleData = ["Address","Purpose of Visit","Next Visit Discussion"]
    
    var filteredSearchResults: [weeklyPJPDetails]?
    let cellSpacingHeight: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let details = weeklyPJPDetails(Address: "Opp RTC complex, Rajahmundry,West Godavary,Andhra pradesh,India,", PurposeofVisit: "Wanted plywood, to check with the manager",NextVisitDiscussion: "14-June-2018")
        
        
        arrOfData = [details]
        
        filteredSearchResults = arrOfData
        
        self.setupTableView()
        
    }
    
    
    //MARK: - Setup TableView
    func setupTableView() -> Void
    {
        
        self.tblWeeklyPJPDetails.tableFooterView = UIView()
        self.tblWeeklyPJPDetails.backgroundColor = UIColor.clear
        
        self.tblWeeklyPJPDetails.estimatedRowHeight = 50.0
        self.tblWeeklyPJPDetails.rowHeight = UITableViewAutomaticDimension
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyPJPDetailsCell", for: indexPath)
        
        var mainArray = [[String]]()
        
        for item in filteredSearchResults!
        {
            var subArray = [String]()
            
            subArray.append(item.Address)
            subArray.append(item.PurposeofVisit)
            subArray.append(item.NextVisitDiscussion)
            
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
