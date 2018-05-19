//
//  ClientHistoryViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 27/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class ClientHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchBarDelegate {
  

    
    @IBOutlet weak var tblHistory: UITableView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    let arrOfData = ["Ganesh","Raju","Roja","Sandeep","Susanth","Ben","bull","henry","John","payal","Nancy"]
    var filteredSearchResults: [String]?
    let cellSpacingHeight: CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredSearchResults = arrOfData
        self.setupTableView()
        self.setupSearchBar()
 
    }
    //MARK: - Setup TableView
    func setupTableView() -> Void
    {
        
        self.tblHistory.tableFooterView = UIView()
        self.tblHistory.backgroundColor = UIColor.clear
    }
    
    //MARK: - Setup Search bar
    
    func setupSearchBar() -> Void
    {
        mySearchBar.delegate = self
 
        for s in mySearchBar.subviews[0].subviews {
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
        
        filteredSearchResults = searchText.isEmpty ? arrOfData : arrOfData.filter({ (item:String) -> Bool in
 
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        self.tblHistory.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.mySearchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.mySearchBar.showsCancelButton = false
        //self.mySearchBar.text = ""
        self.mySearchBar.resignFirstResponder()
        self.tblHistory.reloadData()
    }
    //MARK: - tableview Data source and delegate methods..
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return filteredSearchResults!.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
     
        return 1
 
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientHistoryCell", for: indexPath)
       
        cell.textLabel!.text = filteredSearchResults?[indexPath.section]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.backgroundColor = UIColor.clear
        
        
        // Cell appearance...
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        cell.layer.borderColor = UIColor.getCustomOrangeColor().cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true

        // first create UIImageView
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: cell.frame.height/2, height: cell.frame.height/2))
        imageView.image = #imageLiteral(resourceName: "rightArrow")
        
        // then set it as cellAccessoryType
        cell.accessoryView = imageView

        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedStr = filteredSearchResults![indexPath.section]
        
        print("You selected :\(selectedStr)")
        
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
